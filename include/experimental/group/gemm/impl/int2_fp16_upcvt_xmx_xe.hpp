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
/// Group-level GEMM impl for int2 weights with fp16 activations:
///  - Activations (matA) are loaded as fp16 and fed directly to XMX (no
///    quantization of A).
///  - Weights (matB) are stored as int2x16 (16 codes per uint32). Codes are
///    interpreted as signed two's complement -> {0, +1, -2, -1}. Each fp16
///    scale is shared across `dequant_s` consecutive K-elements per N-column.
///  - Per int2 tile, we unpack codes to fp16 via bit-blending (no zero-point)
///    and elementwise multiply by the per-K-group fp16 scale.
///  - The dequantized fp16 B tile is re-laid in VNNI-2 and consumed by XMX
///    fp16 x fp16 -> f32 DPAS together with the fp16 A tile.

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
class gemm_t<compute_policy_int2_fp16_upcvt_xmx<compute_attr_,
                     perf_tuning_knob_, dtype_scale_, dequant_s_,
                     mma_xmx_m_, gpu_arch::Xe, use_unaligned_n_>,
        tile_shape_, mem_desc_a_t_, mem_desc_b_t_, pre_processing_t_> {
public:
    using mem_desc_a_t = mem_desc_a_t_;
    using mem_desc_b_t = mem_desc_b_t_;
    using tile_shape = tile_shape_;
    using pre_processing_t = pre_processing_t_;
    using compute_policy = compute_policy_int2_fp16_upcvt_xmx<compute_attr_,
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
                          remove_const_t<int2x16>>::value,
            "this is for 2bit matB packed as int2x16");

    /// 16 codes per int2x16 (uint32_t).
    static constexpr uint32_t pack_ratio = get_packed_num<dtype_b>::value;
    static_assert(pack_ratio == 16, "pack_ratio for int2x16 must be 16");

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
            "dtype_mma_a must be fp16 for int2_fp16_upcvt");
    static_assert(std::is_same<remove_const_t<dtype_mma_b>,
                          remove_const_t<fp16>>::value,
            "dtype_mma_b must be fp16 for int2_fp16_upcvt");

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
    static constexpr uint32_t block_size_y_b
            = compute_policy::block_bytes_y_b / sizeof(dtype_mma_b);

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

    // matB is loaded as int2x16 (one element packs 16 int2 codes along K).
    // Storage layout: row-major int2x16, shape (K/pack_ratio, N).
    // i.e. each int2x16 word = 16 K-rows for ONE N-column.
    using matB_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b,
            tile_size_y_b / pack_ratio, block_size_x_b,
            block_size_y_b / pack_ratio, reg_layout::tiled>;
    using matB_t = subgroup::tile_t<dtype_b, matB_tile_desc_t>;
    // Per-packed-K-row tile (1 row of int2x16). Used when
    // compute_policy::use_unaligned_n is true: one block_1d HW load per row,
    // 8 rows per matB tile. block_1d has no surface-pitch alignment so any
    // matrix_n is supported with no driver-side padding.
    using matB_row_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b, 1,
            block_size_x_b, 1, reg_layout::tiled>;
    using matB_row_t = subgroup::tile_t<dtype_b, matB_row_tile_desc_t>;
    using matB_block2d_payload_t = subgroup::mem_payload_t<mem_desc_b_t,
            matB_tile_desc_t,
            subgroup::msg_type_v<matB_tile_desc_t, mem_space_b>, arch_tag>;
    // For block_1d we force a 1-element (==4-byte) mem-desc alignment so
    // the per-row load picks `mem_dtype = uint32_t` rather than
    // `uint64_t`. With odd matrix_n the row pitch in bytes is 4 mod 8,
    // which would violate u64-load alignment. u32 loads are fine for
    // any 4-byte-aligned row offset.
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

    // Dequantized matB tile: fp16, VNNI-2 tiled to feed XMX. Block size in
    // fp16 elements: block_size_x_b cols x block_size_y_b rows.
    using matB_acc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b,
            tile_size_y_b, block_size_x_b, block_size_y_b,
            reg_layout::vnni_tiled>;
    using matB_acc_t = subgroup::tile_t<dtype_mma_b, matB_acc_tile_desc_t>;

public:
    static_assert((k_stride % (block_size_y_b) == 0),
            "k_stride%(block_size_y_b) == 0");
    static_assert((dequant_s % (block_size_y_b) == 0),
            "dequant_s%(block_size_y_b) == 0");
    static_assert(
            (k_stride % (dequant_s) == 0) || (dequant_s % (k_stride) == 0),
            "k_stride should match with dequant_s");

    static constexpr uint32_t block_size_y_scale
            = (k_stride + dequant_s - 1) / dequant_s;
    static constexpr uint32_t tile_size_y_scale = block_size_y_scale;

    static constexpr uint32_t scale_addr_update_freq
            = (k_stride < dequant_s) ? dequant_s / k_stride : 1;

    using mem_desc_scale_t
            = mem_desc_t<dtype_scale, mem_layout::row_major, mem_space::global>;
    // 1-elt-aligned alias used on the unaligned-N path so the scale
    // payload picks `mem_dtype = fp16` (per-lane fp16 loads, 2-byte
    // aligned) instead of u64/u32 which would need scale_ld %4 / %2.
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
    // current only support matA from slm
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
        // For the unaligned-N path we wrap the (8-elt-aligned) matB
        // mem-desc in a 1-elt-aligned alias so block_1d picks u32 loads.
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
        // For the unaligned-N path we wrap the scale mem-desc in a
        // 1-elt-aligned alias so unaligned_2d picks fp16 mem_dtype.
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
                // Per-packed-K-row block_1d load: 8 HW loads, one cache line
                // each, advancing y by 1 packed row per call. Total advance
                // after the loop equals matB_t::tile_size_y, so the post-load
                // update_tdesc(matB_t::tile_size_y) below is skipped.
                constexpr uint32_t row_count
                        = matB_t::tile_size_y; // 8 packed rows
                constexpr uint32_t row_elems
                        = matB_t::tile_size_x; // 16 int2x16 cols
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
            // matA is already fp16; just elementwise reinterpret/copy.
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
    /// Unpack the int2x16-packed matB tile into an fp16 VNNI-2-laid tile, with
    /// the per-K-group fp16 scale already applied. Single pass, no scratch.
    ///
    /// Codes are restricted by the driver to {0b00, 0b01, 0b11}, i.e. values
    /// {0, +1, -1}. Each weight's contribution is therefore drawn from the
    /// 3-element set {0, +scale, -scale}, so there is *no* fp16 multiply at
    /// all in the inner loop: we precompute `+scale_vec` and `neg_scale_vec`
    /// (one fp16 XOR with 0x8000 -- just sign flip) and select by code bits.
    ///
    /// Per-lane logic (b1 = sign bit, b0 = magnitude bit):
    ///   mag_mask  = 0 - b0       // 0x0000 or 0xFFFF
    ///   sign_xor  = (0 - b1) & 0x8000
    ///   out_bits  = (scale_bits ^ sign_xor) & mag_mask
    /// All operations are uint16, no fp ops, fully branchless.
    ///
    /// Output layout: `matB_acc` is in `reg_layout::vnni_tiled`. Within each
    /// block, a K-pair `(k, k+1)` for column `col` lives at
    ///   dst_blk[(k/2)*2*BSX + col*2 + (k%2)]
    /// We emit directly there with a stride-2 select, fusing what used to be
    /// a row-major scratch + VNNI shuffle pass.
    inline void dequantize(
            matB_acc_t &matB_acc, matB_t &matB, scale_t &scale) {
        constexpr uint32_t num_block_x = tile_size_x_b / block_size_x_b;
        constexpr uint32_t num_block_y
                = (tile_size_y_b / pack_ratio) / (block_size_y_b / pack_ratio);
        // Number of Y-blocks that share one scale row. When dequant_s
        // exceeds the SG K-tile (e.g. channelwise: dequant_s == K), the SG
        // sees only one scale row, so all num_block_y blocks share it.
        constexpr uint32_t block_b_y_per_scale_raw
                = dequant_s / block_size_y_b;
        constexpr uint32_t blocks_per_scale_row
                = (block_b_y_per_scale_raw > num_block_y)
                ? num_block_y
                : block_b_y_per_scale_raw;
        constexpr uint32_t num_scale_rows
                = num_block_y / blocks_per_scale_row;
        constexpr uint32_t pack_count = block_size_y_b / pack_ratio;
        constexpr uint32_t BSX = block_size_x_b;
        constexpr uint32_t BSY = block_size_y_b;
        static_assert(pack_count * pack_ratio == BSY,
                "block_size_y_b must be divisible by pack_ratio");
        static_assert((BSY % 2) == 0,
                "block_size_y_b must be even for VNNI-2 layout");
        static_assert(num_scale_rows * blocks_per_scale_row == num_block_y,
                "num_block_y must be a multiple of blocks_per_scale_row");

        // Loop nest order: (scale-row g, n-block j, i-within-scale-row ii).
        // This hoists the scale load + sign-flip out of the i-dimension so
        // that for typical configs (k_stride == dequant_s ==> num_scale_rows
        // == 1, block_b_y_per_scale == num_block_y) the (BSX-wide) scale_u16
        // / neg_scale_u16 vectors are materialized exactly *once* per j
        // instead of `block_b_y_per_scale` times. The unpack body is
        // unchanged.
#pragma unroll
        for (uint32_t g = 0; g < num_scale_rows; ++g) {
#pragma unroll
            for (uint32_t j = 0; j < num_block_x; ++j) {
                // Scale: one fp16 per N-column (BSX-wide), shared across
                // block_b_y_per_scale Y-blocks.
                const int scale_block_id = g * num_block_x + j;
                auto scale_vec
                        = scale.reg.xetla_select<scale_t::block_size_x, 1>(
                                scale_block_id * scale_t::block_size_x);
                xetla_vector<uint16_t, BSX> scale_u16
                        = scale_vec.xetla_format<uint16_t>();

#pragma unroll
                for (uint32_t ii = 0; ii < blocks_per_scale_row; ++ii) {
                    const uint32_t i = g * blocks_per_scale_row + ii;
                    const int block_id = (i * num_block_x + j);

                    // matB block: pack_count packed-rows x BSX cols of int2x16.
                    auto matB_blk_u32
                            = matB.reg
                                      .xetla_select<matB_t::block_elems, 1>(
                                              block_id * matB_t::block_elems)
                                      .xetla_format<uint32_t>();

                    // Destination view: BSX*BSY fp16 in VNNI-2 layout, viewed
                    // as uint16 so we can write the bit-pattern result
                    // directly.
                    auto dst_blk
                            = matB_acc.reg
                                      .xetla_select<matB_acc_t::block_elems, 1>(
                                              block_id
                                              * matB_acc_t::block_elems);
                    auto dst_blk_u16 = dst_blk.xetla_format<uint16_t>();

                    // Single fused pass: walk packed rows, and for each of
                    // the 16 codes per word, emit BSX fp16 lanes into VNNI
                    // position. We work at uint16 width: a uint32 word holds
                    // 16 K-codes packed as (low u16: codes 0..7, high u16:
                    // codes 8..15), each u16 holding 8 codes of 2 bits.
                    // Operating at 16-bit width halves the ALU traffic vs.
                    // shifting the u32 word for every c, and lets us replace
                    // the (sign_mask & neg_scale) | (~sign_mask & scale)
                    // blend with a single XOR (sign bit = code bit 1
                    // shifted into 0x8000).
#pragma unroll
                    for (uint32_t rp = 0; rp < pack_count; ++rp) {
                        // BSX x u32 -> 2*BSX x u16 (LE: even = low half,
                        // odd = high half of each word).
                        auto src_u16 = matB_blk_u32
                                               .xetla_select<BSX, 1>(rp * BSX)
                                               .xetla_format<uint16_t>();
                        auto lo16 = src_u16.xetla_select<BSX, 2>(0);
                        auto hi16 = src_u16.xetla_select<BSX, 2>(1);

#pragma unroll
                        for (uint32_t c = 0; c < pack_ratio / 2; ++c) {
                            // --- low half: K-position c (0..7) ---
                            {
                                xetla_vector<uint16_t, BSX> code_u16
                                        = (lo16 >> (2 * c))
                                        & uint16_t(0x3u);
                                xetla_vector<uint16_t, BSX> sign_xor
                                        = (code_u16 << 14)
                                        & uint16_t(0x8000u);
                                xetla_vector<uint16_t, BSX> mag_mask
                                        = uint16_t(0)
                                        - (code_u16 & uint16_t(1));
                                xetla_vector<uint16_t, BSX> result
                                        = (scale_u16 ^ sign_xor) & mag_mask;
                                const uint32_t row = rp * pack_ratio + c;
                                const uint32_t k_pair = row >> 1;
                                const uint32_t row_in_pair = row & 1u;
                                dst_blk_u16.xetla_select<BSX, 2>(
                                        k_pair * 2u * BSX + row_in_pair)
                                        = result;
                            }
                            // --- high half: K-position c+8 (8..15) ---
                            {
                                xetla_vector<uint16_t, BSX> code_u16
                                        = (hi16 >> (2 * c))
                                        & uint16_t(0x3u);
                                xetla_vector<uint16_t, BSX> sign_xor
                                        = (code_u16 << 14)
                                        & uint16_t(0x8000u);
                                xetla_vector<uint16_t, BSX> mag_mask
                                        = uint16_t(0)
                                        - (code_u16 & uint16_t(1));
                                xetla_vector<uint16_t, BSX> result
                                        = (scale_u16 ^ sign_xor) & mag_mask;
                                const uint32_t row
                                        = rp * pack_ratio + c + 8;
                                const uint32_t k_pair = row >> 1;
                                const uint32_t row_in_pair = row & 1u;
                                dst_blk_u16.xetla_select<BSX, 2>(
                                        k_pair * 2u * BSX + row_in_pair)
                                        = result;
                            }
                        }
                    }
                }
            }
        }
    }

    __XETLA_API static void update_sg_tile_tdesc(
            arguments_t &args, int32_t sg_idx, int32_t sg_idy) {
        int32_t tile_offset_n = sg_idx * sg_tile_n;
        int32_t tile_offset_m = sg_idy * sg_tile_m;

        args.matA_base_desc.update_coord_y(tile_offset_m);
        // matB is packed along K (rows) with pack_ratio = 16; N coordinate is
        // in native fp16 columns.
        args.matB_base_desc.update_coord_x(tile_offset_n);
        args.scale_base_desc.update_coord_x(tile_offset_n);
    }
};

/// @} xetla_gemm

} // namespace gpu::xetla::group
