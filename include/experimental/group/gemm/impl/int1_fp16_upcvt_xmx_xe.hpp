/*******************************************************************************
* Copyright (c) 2022-2023 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

/// @file
/// C++ API
///
/// Group-level GEMM impl for int1 weights with fp16 activations.
///  - Activations (matA) are loaded as fp16 and fed directly to XMX.
///  - Weights (matB) are stored as int1x32 (32 codes per uint32). Codes are
///    interpreted as {0 -> +1, 1 -> -1}. Each fp16 scale is shared across
///    `dequant_s` consecutive K-elements per N-column.
///  - Per int1 tile, dequantize is a single XOR per code: the scale's sign
///    bit is flipped iff the code bit is 1, giving exactly +/- scale. No
///    multiplies, no magnitude masks (no zero codes).
///  - The dequantized fp16 B tile is laid out VNNI-2 and consumed by XMX
///    fp16 x fp16 -> f32 DPAS.
///
/// matB block sizing (different from int2):
///   matB_acc block_size_y = 16 fp16 (XMX K-block).
///   matB packed block_size_y = 1 packed word (== 32 fp16 K-rows = 2
///   matB_acc blocks). The dequantize loop emits a low- and high-half acc
///   block per packed block.

#pragma once

#include "experimental/group/gemm/common.hpp"
#include "experimental/group/gemm/compute_policy.hpp"

namespace gpu::xetla::group {

/// @addtogroup xetla_gemm
/// @{

template <typename compute_attr_, typename perf_tuning_knob_,
        typename tile_shape_, typename mem_desc_a_t_, typename mem_desc_b_t_,
        typename dtype_scale_, int dequant_s_, int mma_xmx_m_,
        bool use_unaligned_n_, typename pre_processing_t_>
class gemm_t<compute_policy_int1_fp16_upcvt_xmx<compute_attr_,
                     perf_tuning_knob_, dtype_scale_, dequant_s_,
                     mma_xmx_m_, gpu_arch::Xe, use_unaligned_n_>,
        tile_shape_, mem_desc_a_t_, mem_desc_b_t_, pre_processing_t_> {
public:
    using mem_desc_a_t = mem_desc_a_t_;
    using mem_desc_b_t = mem_desc_b_t_;
    using tile_shape = tile_shape_;
    using pre_processing_t = pre_processing_t_;
    using compute_policy = compute_policy_int1_fp16_upcvt_xmx<compute_attr_,
            perf_tuning_knob_, dtype_scale_, dequant_s_, mma_xmx_m_,
            gpu_arch::Xe, use_unaligned_n_>;
    static constexpr uint32_t k_stride = compute_policy::k_stride;

    static constexpr uint32_t sg_tile_m = tile_shape::sg_tile_size_y;
    static constexpr uint32_t sg_tile_n = tile_shape::sg_tile_size_x;
    static constexpr uint32_t wg_size_x = tile_shape::wg_size_x;
    static constexpr uint32_t wg_size_y = tile_shape::wg_size_y;
    using work_group_t = typename tile_shape::work_group_t;

    static constexpr gpu_arch arch_tag = compute_policy::arch_tag;
    static constexpr uint32_t dequant_s = compute_policy::dequant_s;
    using dtype_b = typename mem_desc_b_t::dtype;
    static_assert(std::is_same<remove_const_t<dtype_b>,
                          remove_const_t<int1x32>>::value,
            "this is for 1bit matB packed as int1x32");

    /// 32 codes per int1x32 (uint32_t).
    static constexpr uint32_t pack_ratio = get_packed_num<dtype_b>::value;
    static_assert(pack_ratio == 32, "pack_ratio for int1x32 must be 32");

    static constexpr mem_layout mem_layout_a = mem_desc_a_t::layout;
    static constexpr mem_layout mem_layout_b = mem_desc_b_t::layout;
    static constexpr bool is_col_major_a
            = mem_layout_a == mem_layout::col_major;
    static constexpr bool is_col_major_b
            = mem_layout_b == mem_layout::col_major;

private:
    /******** set data type **********/
    using dtype_a = typename mem_desc_a_t::dtype;
    using dtype_mma_acc = typename compute_policy::dtype_mma_acc;
    using dtype_mma_a = typename compute_policy::dtype_mma_a;
    using dtype_mma_b = typename compute_policy::dtype_mma_b;
    using dtype_scale = typename compute_policy::dtype_scale;

    static_assert(std::is_same<remove_const_t<dtype_mma_a>,
                          remove_const_t<fp16>>::value,
            "dtype_mma_a must be fp16 for int1_fp16_upcvt");
    static_assert(std::is_same<remove_const_t<dtype_mma_b>,
                          remove_const_t<fp16>>::value,
            "dtype_mma_b must be fp16 for int1_fp16_upcvt");

    /******** set memory attribute **********/
    static constexpr mem_space mem_space_a = mem_desc_a_t::space;
    static constexpr mem_space mem_space_b = mem_desc_b_t::space;

    static constexpr bool is_local_a = mem_space_a == mem_space::local;
    static constexpr bool is_local_b = mem_space_b == mem_space::local;
    static constexpr tdesc_update_dir update_dir_a = is_col_major_a
            ? tdesc_update_dir::y_dir
            : tdesc_update_dir::x_dir;
    static constexpr tdesc_update_dir update_dir_b = is_col_major_b
            ? tdesc_update_dir::x_dir
            : tdesc_update_dir::y_dir;
    static_assert(!is_col_major_b, "only support MatB row-major for now");
    static_assert((!is_local_a) && (!is_local_b),
            "only support from global memory for now");

    static constexpr uint32_t stages = compute_policy::stages;
    static constexpr uint32_t sync_freq = compute_policy::sync_freq;

    /******** set tile layout && worker scope **********/
    static constexpr uint32_t tile_size_x_a = k_stride;
    static constexpr uint32_t tile_size_y_a = sg_tile_m;
    static constexpr uint32_t tile_size_x_b = sg_tile_n;
    static constexpr uint32_t tile_size_y_b = k_stride;
    static constexpr uint32_t tile_size_x_c = sg_tile_n;
    static constexpr uint32_t tile_size_y_c = sg_tile_m;

    static constexpr uint32_t block_size_x_a
            = compute_policy::block_bytes_x_a / sizeof(dtype_mma_a);
    static constexpr uint32_t block_size_y_a
            = (compute_policy::block_size_y_a > tile_size_y_a)
            ? tile_size_y_a
            : compute_policy::block_size_y_a;

    static constexpr uint32_t block_size_x_b = compute_policy::block_size_x_b;
    // matB_acc block in K (fp16 rows) = XMX K-block = 32 B / sizeof(fp16).
    static constexpr uint32_t block_size_y_b_acc
            = compute_policy::block_bytes_y_b / sizeof(dtype_mma_b); // 16
    // matB packed block in K (packed-words). 1 packed word covers
    // pack_ratio (=32) fp16 K-rows == 2 matB_acc blocks.
    static constexpr uint32_t block_size_y_b_packed_words = 1u;
    static constexpr uint32_t block_size_y_b_packed_fp16
            = block_size_y_b_packed_words * pack_ratio; // 32
    static_assert(block_size_y_b_packed_fp16 % block_size_y_b_acc == 0,
            "packed Y-block must cover a whole number of matB_acc Y-blocks");
    static constexpr uint32_t acc_blocks_per_packed
            = block_size_y_b_packed_fp16 / block_size_y_b_acc; // 2

    /******** set tile **********/
    static constexpr bool is_vnni_tiled_a
            = (sizeof(dtype_a) < sizeof(uint32_t)) && is_col_major_a;
    static constexpr reg_layout reg_layout_a
            = is_vnni_tiled_a ? reg_layout::vnni_tiled : reg_layout::tiled;
    using matA_tile_desc_t = subgroup::tile_desc_t<tile_size_x_a, tile_size_y_a,
            block_size_x_a, block_size_y_a, reg_layout_a>;
    using matA_t = subgroup::tile_t<dtype_a, matA_tile_desc_t>;
    using matA_payload_t = subgroup::mem_payload_t<mem_desc_a_t,
            matA_tile_desc_t,
            subgroup::msg_type_v<matA_tile_desc_t, mem_space_a>, arch_tag>;
    using matA_acc_t = subgroup::tile_t<dtype_mma_a, matA_tile_desc_t>;
    using matA_prefetch_payload_t = subgroup::prefetch_payload_t<mem_desc_a_t,
            subgroup::tile_desc_t<tile_size_x_a, tile_size_y_a, 1, 1>,
            wg_size_x, arch_tag>;

    // matB packed: row-major int1x32, shape (K/pack_ratio, N).
    // Each int1x32 word = 32 K-rows for ONE N-column.
    using matB_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b,
            tile_size_y_b / pack_ratio, block_size_x_b,
            block_size_y_b_packed_words, reg_layout::tiled>;
    using matB_t = subgroup::tile_t<dtype_b, matB_tile_desc_t>;
    // Per-packed-K-row tile (1 row of int1x32). Used when
    // compute_policy::use_unaligned_n is true.
    using matB_row_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b, 1,
            block_size_x_b, 1, reg_layout::tiled>;
    using matB_row_t = subgroup::tile_t<dtype_b, matB_row_tile_desc_t>;
    using matB_block2d_payload_t = subgroup::mem_payload_t<mem_desc_b_t,
            matB_tile_desc_t,
            subgroup::msg_type_v<matB_tile_desc_t, mem_space_b>, arch_tag>;
    // Force a 1-element (==4-byte) mem-desc alignment so block_1d picks
    // `mem_dtype = uint32_t` and tolerates any 4-byte-aligned row offset.
    using mem_desc_b_block1d_t = mem_desc_t<dtype_b, mem_desc_b_t::layout,
            mem_desc_b_t::space, /*alignment=*/1>;
    using matB_row_payload_t = subgroup::mem_payload_t<mem_desc_b_block1d_t,
            matB_row_tile_desc_t, msg_type::block_1d, arch_tag>;
    using matB_payload_t = std::conditional_t<compute_policy::use_unaligned_n,
            matB_row_payload_t, matB_block2d_payload_t>;
    static_assert(!compute_policy::use_unaligned_n
                    || std::is_same_v<typename matB_row_payload_t::mem_dtype,
                            uint32_t>,
            "block_1d matB row load must use u32 mem_dtype to tolerate "
            "4-byte-aligned-but-not-8 row offsets");
    using matB_prefetch_payload_t = subgroup::prefetch_payload_t<mem_desc_b_t,
            matB_tile_desc_t, wg_size_y, arch_tag>;

    // Dequantized matB tile: fp16, VNNI-2 tiled to feed XMX.
    using matB_acc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b,
            tile_size_y_b, block_size_x_b, block_size_y_b_acc,
            reg_layout::vnni_tiled>;
    using matB_acc_t = subgroup::tile_t<dtype_mma_b, matB_acc_tile_desc_t>;

public:
    static_assert((k_stride % block_size_y_b_acc == 0),
            "k_stride must be a multiple of XMX K-block (16 fp16)");
    static_assert((k_stride % pack_ratio == 0),
            "k_stride must be a multiple of pack_ratio (32)");
    static_assert((dequant_s % block_size_y_b_acc == 0),
            "dequant_s%(block_size_y_b_acc) == 0");
    static_assert(
            (k_stride % dequant_s == 0) || (dequant_s % k_stride == 0),
            "k_stride should match with dequant_s");

    static constexpr uint32_t block_size_y_scale
            = (k_stride + dequant_s - 1) / dequant_s;
    static constexpr uint32_t tile_size_y_scale = block_size_y_scale;

    static constexpr uint32_t scale_addr_update_freq
            = (k_stride < dequant_s) ? dequant_s / k_stride : 1;

    using mem_desc_scale_t
            = mem_desc_t<dtype_scale, mem_layout::row_major, mem_space::global>;
    using mem_desc_scale_unaligned_t
            = mem_desc_t<dtype_scale, mem_layout::row_major, mem_space::global,
                    /*alignment=*/1>;

    using matAcc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_c,
            tile_size_y_c, block_size_x_b, block_size_y_a, reg_layout::tiled>;
    using matAcc_t = subgroup::tile_t<dtype_mma_acc, matAcc_tile_desc_t>;

private:
    using scale_tile_desc_t
            = subgroup::tile_desc_t<tile_size_x_b, tile_size_y_scale,
                    block_size_x_b, block_size_y_scale, reg_layout::tiled>;
    using scale_t = subgroup::tile_t<dtype_scale, scale_tile_desc_t>;
    using scale_block2d_payload_t
            = subgroup::mem_payload_t<mem_desc_scale_t, scale_tile_desc_t,
                    subgroup::msg_type_v<scale_tile_desc_t, mem_space::global>,
                    arch_tag>;
    using scale_unaligned_payload_t
            = subgroup::mem_payload_t<mem_desc_scale_unaligned_t,
                    scale_tile_desc_t, msg_type::unaligned_2d, arch_tag>;
    using scale_payload_t
            = std::conditional_t<compute_policy::use_unaligned_n,
                    scale_unaligned_payload_t, scale_block2d_payload_t>;
    using scale_prefetch_payload_t
            = subgroup::prefetch_payload_t<mem_desc_scale_t, scale_tile_desc_t,
                    1, arch_tag>;

    using tile_mma = subgroup::tile_mma_t<matAcc_t, matAcc_t, matB_acc_t,
            matA_acc_t, mma_engine::xmx, arch_tag,
            typename std::enable_if<(arch_tag == gpu_arch::Xe)>::type,
            typename compute_policy::arch_attr::mma_attr>;
    static constexpr bool enable_periodic_sync = (sync_freq != 0);
    static constexpr uint32_t barrier_count_x = wg_size_y > 1 ? wg_size_x : 0;
    static constexpr uint32_t barrier_count_y = wg_size_x > 1 ? wg_size_y : 0;

public:
    static constexpr uint32_t barrier_count
            = enable_periodic_sync ? barrier_count_x + barrier_count_y : 0;
    static constexpr uint32_t slm_size = is_local_a
            ? sg_tile_m * wg_size_y * k_stride * sizeof(dtype_a)
            : 0;

    static constexpr msg_type msg_type_a = matA_payload_t::message_type;
    static constexpr msg_type msg_type_b = matB_payload_t::message_type;

    /// @brief Arguments for gemm.
    struct arguments_t {
        mem_desc_a_t matA_base_desc;
        mem_desc_b_t matB_base_desc;
        uint32_t inner_loop_count;
        mem_desc_scale_t scale_base_desc;

        inline arguments_t() = default;

        inline arguments_t(mem_desc_a_t matA_desc, mem_desc_b_t matB_desc,
                uint32_t loop_count, mem_desc_scale_t scale_desc)
            : matA_base_desc(matA_desc)
            , matB_base_desc(matB_desc)
            , inner_loop_count(loop_count)
            , scale_base_desc(scale_desc) {}

        inline arguments_t(const arguments_t &args)
            : matA_base_desc(args.matA_base_desc)
            , matB_base_desc(args.matB_base_desc)
            , inner_loop_count(args.inner_loop_count)
            , scale_base_desc(args.scale_base_desc) {}

        inline arguments_t &operator=(const arguments_t &args) {
            this->matA_base_desc = args.matA_base_desc;
            this->matB_base_desc = args.matB_base_desc;
            this->inner_loop_count = args.inner_loop_count;
            this->scale_base_desc = args.scale_base_desc;
            return *this;
        }

        inline void init(mem_desc_a_t matA_desc, mem_desc_b_t matB_desc,
                uint32_t loop_count, mem_desc_scale_t scale_desc) {
            matA_base_desc = matA_desc;
            matB_base_desc = matB_desc;
            inner_loop_count = loop_count;
            scale_base_desc = scale_desc;
        }
    };

    __XETLA_API static int get_matC_offset_x(work_group_t &g) {
        int32_t sg_idx = g.get_id() % wg_size_x;
        return sg_idx * sg_tile_n;
    }

    __XETLA_API static int get_matC_offset_y(work_group_t &g) {
        int32_t sg_idy = g.get_id() / wg_size_x;
        return sg_idy * sg_tile_m;
    }

    __XETLA_API static void release(uint8_t nbarrier_id = 0) {
        static constexpr bool need_local_fence
                = (mem_space_a == mem_space::local)
                || (mem_space_b == mem_space::local);
        if constexpr (need_local_fence) {
            xetla_fence<memory_kind::shared_local>();
        }
        xetla_fence<memory_kind::untyped_global>();
        static constexpr uint32_t wg_size = wg_size_x * wg_size_y;
        if constexpr (wg_size > 1) {
            xetla_nbarrier_t<wg_size, wg_size, arch_tag> nbarrier;
            nbarrier.init_nbarrier(
                    nbarrier_id, nbarrier_role::producer_consumer);
            nbarrier.arrive_wait();
        }
    }

    /// @brief Main execution function for gemm.
    __XETLA_API KERNEL_FUNC void operator()(work_group_t &g, matAcc_t &matAcc,
            arguments_t args, [[maybe_unused]] uint32_t slm_base = 0,
            uint32_t nbarrier_base = 0) {
        int32_t sg_idx = g.get_id() % wg_size_x;
        int32_t sg_idy = g.get_id() / wg_size_x;
        update_sg_tile_tdesc(args, sg_idx, sg_idy);

        matA_t matA;
        matB_t matB;
        scale_t scale;

        matA_payload_t matA_payload(args.matA_base_desc);
        auto make_matB_payload = [&]() {
            if constexpr (compute_policy::use_unaligned_n) {
                mem_desc_b_block1d_t md(args.matB_base_desc.base,
                        args.matB_base_desc.shape, args.matB_base_desc.coord);
                return matB_payload_t(md);
            } else {
                return matB_payload_t(args.matB_base_desc);
            }
        };
        matB_payload_t matB_payload = make_matB_payload();
        auto make_scale_payload = [&]() {
            if constexpr (compute_policy::use_unaligned_n) {
                mem_desc_scale_unaligned_t md(args.scale_base_desc.base,
                        args.scale_base_desc.shape,
                        args.scale_base_desc.coord);
                return scale_payload_t(md);
            } else {
                return scale_payload_t(args.scale_base_desc);
            }
        };
        scale_payload_t scale_payload = make_scale_payload();
        matA_prefetch_payload_t matA_prefetch_payload(
                args.matA_base_desc, sg_idx);
        matB_prefetch_payload_t matB_prefetch_payload(
                args.matB_base_desc, sg_idy);
        scale_prefetch_payload_t scale_prefetch_payload(
                args.scale_base_desc, 0);

        xetla_nbarrier_t<wg_size_x, wg_size_x, arch_tag> nbarrier_a;
        nbarrier_a.init_nbarrier(
                sg_idy + nbarrier_base, nbarrier_role::producer_consumer);
        xetla_nbarrier_t<wg_size_y, wg_size_y, arch_tag> nbarrier_b;
        nbarrier_b.init_nbarrier(sg_idx + barrier_count_y + nbarrier_base,
                nbarrier_role::producer_consumer);

        int scale_prefetch_addr_i = 0;
        int scale_load_addr_i = 0;
        SW_BARRIER();
#pragma unroll
        for (uint32_t i = 0; i < stages; i++) {
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                    matA_prefetch_payload);
            if constexpr (!compute_policy::use_unaligned_n) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                        matB_prefetch_payload);
            }
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                    scale_prefetch_payload);
            scale_prefetch_addr_i++;
            matA_prefetch_payload.template update_tdesc<update_dir_a>(
                    matA_t::tile_size_x);
            matB_prefetch_payload.template update_tdesc<update_dir_b>(
                    matB_t::tile_size_y);
            if ((scale_prefetch_addr_i % scale_addr_update_freq) == 0) {
                scale_prefetch_payload
                        .template update_tdesc<tdesc_update_dir::y_dir>(
                                scale_t::tile_size_y);
            }
        }

        for (uint32_t i = 0; i < args.inner_loop_count; i++) {
            if constexpr (enable_periodic_sync) {
                if ((i % sync_freq) == 0) {
                    if constexpr (wg_size_x > 1) { nbarrier_a.arrive(); }
                    if constexpr (wg_size_y > 1) { nbarrier_b.arrive(); }
                }
            }
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(
                    matA, matA_payload);
            if constexpr (compute_policy::use_unaligned_n) {
                // Per-packed-K-row block_1d load: row_count packed rows
                // (k_stride/pack_ratio total), one block_1d per row.
                constexpr uint32_t row_count = matB_t::tile_size_y;
                constexpr uint32_t row_elems = matB_t::tile_size_x;
#pragma unroll
                for (uint32_t r = 0; r < row_count; ++r) {
                    matB_row_t matB_row;
                    subgroup::tile_load<cache_hint::cached, cache_hint::cached>(
                            matB_row, matB_payload);
                    matB.reg.xetla_format<uint32_t>()
                            .xetla_select<row_elems, 1>(r * row_elems)
                            = matB_row.reg.xetla_format<uint32_t>();
                    matB_payload.template update_tdesc<update_dir_b>(1);
                }
            } else {
                subgroup::tile_load<cache_hint::cached, cache_hint::cached>(
                        matB, matB_payload);
            }
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(
                    scale, scale_payload);
            scale_load_addr_i++;
            SW_BARRIER();
            if constexpr (stages != 0) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                        matA_prefetch_payload);
                if constexpr (!compute_policy::use_unaligned_n) {
                    subgroup::tile_prefetch<cache_hint::cached,
                            cache_hint::cached>(matB_prefetch_payload);
                }
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                        scale_prefetch_payload);
                scale_prefetch_addr_i++;
            }
            SW_BARRIER();
            matA_payload.template update_tdesc<update_dir_a>(
                    matA_t::tile_size_x);
            if constexpr (!compute_policy::use_unaligned_n) {
                matB_payload.template update_tdesc<update_dir_b>(
                        matB_t::tile_size_y);
            }
            if ((scale_load_addr_i % scale_addr_update_freq) == 0) {
                scale_payload.template update_tdesc<tdesc_update_dir::y_dir>(
                        scale_t::tile_size_y);
            }
            if constexpr (stages != 0) {
                matA_prefetch_payload.template update_tdesc<update_dir_a>(
                        matA_t::tile_size_x);
                matB_prefetch_payload.template update_tdesc<update_dir_b>(
                        matB_t::tile_size_y);
                if ((scale_prefetch_addr_i % scale_addr_update_freq) == 0) {
                    scale_prefetch_payload
                            .template update_tdesc<tdesc_update_dir::y_dir>(
                                    scale_t::tile_size_y);
                }
            }
            SW_BARRIER();
            matA_acc_t matA_acc;
            matB_acc_t matB_acc;
            if constexpr (is_vnni_tiled_a) { subgroup::vnni_reverse(matA); }
            subgroup::elemwise_cvt(matA_acc, matA);
            dequantize(matB_acc, matB, scale);
            SW_BARRIER();
            tile_mma::mma(matAcc, matAcc, matB_acc, matA_acc);
            SW_BARRIER();
            if constexpr (enable_periodic_sync) {
                if ((i % sync_freq) == 0) {
                    if constexpr (wg_size_x > 1) { nbarrier_a.wait(); }
                    if constexpr (wg_size_y > 1) { nbarrier_b.wait(); }
                }
            }
        }
        SW_BARRIER();
    }

private:
    /// Unpack the int1x32-packed matB tile into an fp16 VNNI-2-laid tile,
    /// with the per-K-group fp16 scale already applied.
    ///
    /// Code 0 -> +scale, Code 1 -> -scale. Result fp16 bits = scale_bits ^
    /// (code_bit << 15). Single XOR per code; no fp ops, no magnitude mask
    /// (no zero codes).
    ///
    /// Each packed block holds 1 packed word per N-col. The low 16 bits of
    /// the word correspond to K-rows 0..15 of the lower acc-block; the high
    /// 16 bits correspond to K-rows 0..15 of the upper acc-block.
    ///
    /// VNNI-2 layout within an acc block: K-pair (k, k+1) for col `col`
    /// lives at dst[(k/2)*2*BSX + col*2 + (k%2)].
    inline void dequantize(
            matB_acc_t &matB_acc, matB_t &matB, scale_t &scale) {
        constexpr uint32_t num_block_x = tile_size_x_b / block_size_x_b;
        constexpr uint32_t num_packed_block_y
                = (tile_size_y_b / pack_ratio) / block_size_y_b_packed_words;
        // How many packed-Y blocks share one scale row.
        constexpr uint32_t packed_per_scale_raw
                = dequant_s / block_size_y_b_packed_fp16;
        constexpr uint32_t packed_per_scale
                = (packed_per_scale_raw > num_packed_block_y)
                ? num_packed_block_y
                : packed_per_scale_raw;
        constexpr uint32_t num_scale_rows
                = num_packed_block_y / packed_per_scale;
        constexpr uint32_t BSX = block_size_x_b;
        constexpr uint32_t BSY_acc = block_size_y_b_acc;
        static_assert(num_scale_rows * packed_per_scale == num_packed_block_y,
                "num_packed_block_y must be a multiple of packed_per_scale");
        static_assert(matB_t::block_elems == BSX,
                "int1 packed block must hold exactly BSX uint32 words");

#pragma unroll
        for (uint32_t g_ = 0; g_ < num_scale_rows; ++g_) {
#pragma unroll
            for (uint32_t j = 0; j < num_block_x; ++j) {
                const int scale_block_id = g_ * num_block_x + j;
                auto scale_vec
                        = scale.reg.xetla_select<scale_t::block_size_x, 1>(
                                scale_block_id * scale_t::block_size_x);
                xetla_vector<uint16_t, BSX> scale_u16
                        = scale_vec.xetla_format<uint16_t>();

#pragma unroll
                for (uint32_t ii = 0; ii < packed_per_scale; ++ii) {
                    const uint32_t i_pk = g_ * packed_per_scale + ii;
                    const int packed_block_id = i_pk * num_block_x + j;

                    // Packed block: BSX uint32 words (1 per N-col).
                    auto matB_blk_u32
                            = matB.reg
                                      .xetla_select<matB_t::block_elems, 1>(
                                              packed_block_id
                                              * matB_t::block_elems)
                                      .xetla_format<uint32_t>();

                    // Split each uint32 into low / high uint16 halves.
                    // low half  -> K rows 0..15 of packed word (= acc block
                    //              i_pk*2 + 0)
                    // high half -> K rows 16..31 of packed word (= acc block
                    //              i_pk*2 + 1)
                    auto src_u16 = matB_blk_u32.xetla_format<uint16_t>();
                    auto lo16 = src_u16.xetla_select<BSX, 2>(0);
                    auto hi16 = src_u16.xetla_select<BSX, 2>(1);

                    // Helper to emit one acc-block from a half-vector.
                    auto emit_acc_block = [&](auto half_bits,
                                                  uint32_t acc_block_id) {
                        auto dst_blk
                                = matB_acc.reg
                                          .xetla_select<matB_acc_t::block_elems,
                                                  1>(acc_block_id
                                                  * matB_acc_t::block_elems);
                        auto dst_blk_u16 = dst_blk.xetla_format<uint16_t>();
#pragma unroll
                        for (uint32_t c = 0; c < BSY_acc; ++c) {
                            // bit c of each half_bits lane -> sign of
                            // matching N-col of K-row c of this acc block.
                            xetla_vector<uint16_t, BSX> sign_xor
                                    = (half_bits << uint16_t(15u - c))
                                    & uint16_t(0x8000u);
                            xetla_vector<uint16_t, BSX> result
                                    = scale_u16 ^ sign_xor;
                            const uint32_t k_pair = c >> 1;
                            const uint32_t row_in_pair = c & 1u;
                            dst_blk_u16.xetla_select<BSX, 2>(
                                    k_pair * 2u * BSX + row_in_pair)
                                    = result;
                        }
                    };

                    const uint32_t lo_acc_block_id
                            = (i_pk * acc_blocks_per_packed + 0) * num_block_x
                            + j;
                    const uint32_t hi_acc_block_id
                            = (i_pk * acc_blocks_per_packed + 1) * num_block_x
                            + j;
                    emit_acc_block(lo16, lo_acc_block_id);
                    emit_acc_block(hi16, hi_acc_block_id);
                }
            }
        }
    }

    __XETLA_API static void update_sg_tile_tdesc(
            arguments_t &args, int32_t sg_idx, int32_t sg_idy) {
        int32_t tile_offset_n = sg_idx * sg_tile_n;
        int32_t tile_offset_m = sg_idy * sg_tile_m;

        args.matA_base_desc.update_coord_y(tile_offset_m);
        // matB packed along K with pack_ratio = 32; N coordinate is in
        // native fp16 columns.
        args.matB_base_desc.update_coord_x(tile_offset_n);
        args.scale_base_desc.update_coord_x(tile_offset_n);
    }
};

/// @} xetla_gemm

} // namespace gpu::xetla::group
