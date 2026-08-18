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
/// Group-level GEMM for BITCOS ternary weights with fp16 activations.
///
/// matB is one buffer holding three planes back to back:
///   bitmap   uint32 [K/32][N]   bit c of word (kp,n) = weight(kp*32+c, n) != 0
///   offsets  uint32 [N]         word index where column n's sign run starts
///   signs    uint32 bitstream   one bit per non-zero, column-major
///
/// The bitmap plane has the same shape as an int1 plane, so the tile and
/// payload machinery is inherited unchanged; only the unpack differs.
///
/// There is no pdep on Xe, so a sign bit cannot be scattered onto its lane in
/// one instruction. Instead each lane carries a running rank per column -- the
/// analogue of the CPU kernel's `bitpos` -- which is legal because the k loop
/// walks k contiguously from 0. A sign bit is consumed only where the bitmap
/// says a weight is present, via a 0/1 variable shift, so no per-weight rank
/// arithmetic is needed. At most 32 sign bits are consumed per 32-k block, so
/// one 64-bit window (gathered once per block) always suffices.

#pragma once

#include "experimental/group/gemm/common.hpp"
#include "experimental/group/gemm/compute_policy.hpp"
#include <sycl/ext/intel/experimental/esimd/math.hpp>

namespace gpu::xetla::group {

/// @addtogroup xetla_gemm
/// @{

template <typename compute_attr_, typename perf_tuning_knob_,
        typename tile_shape_, typename mem_desc_a_t_, typename mem_desc_b_t_,
        typename dtype_scale_, int dequant_s_, int mma_xmx_m_,
        bool use_unaligned_n_, typename pre_processing_t_>
class gemm_t<compute_policy_bitcos_fp16_upcvt_xmx<compute_attr_,
                     perf_tuning_knob_, dtype_scale_, dequant_s_, mma_xmx_m_,
                     gpu_arch::Xe, use_unaligned_n_>,
        tile_shape_, mem_desc_a_t_, mem_desc_b_t_, pre_processing_t_> {
public:
    using mem_desc_a_t = mem_desc_a_t_;
    using mem_desc_b_t = mem_desc_b_t_;
    using tile_shape = tile_shape_;
    using pre_processing_t = pre_processing_t_;
    using compute_policy = compute_policy_bitcos_fp16_upcvt_xmx<compute_attr_,
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
            "BITCOS bitmap plane is carried as int1x32");

    static constexpr uint32_t pack_ratio = get_packed_num<dtype_b>::value;
    static_assert(pack_ratio == 32, "pack_ratio for the bitmap must be 32");

    static constexpr mem_layout mem_layout_a = mem_desc_a_t::layout;
    static constexpr mem_layout mem_layout_b = mem_desc_b_t::layout;
    static constexpr bool is_col_major_a
            = mem_layout_a == mem_layout::col_major;
    static constexpr bool is_col_major_b
            = mem_layout_b == mem_layout::col_major;

private:
    using dtype_a = typename mem_desc_a_t::dtype;
    using dtype_mma_acc = typename compute_policy::dtype_mma_acc;
    using dtype_mma_a = typename compute_policy::dtype_mma_a;
    using dtype_mma_b = typename compute_policy::dtype_mma_b;
    using dtype_scale = typename compute_policy::dtype_scale;

    static_assert(std::is_same<remove_const_t<dtype_mma_a>,
                          remove_const_t<fp16>>::value,
            "BITCOS upcvt targets fp16 MMA");
    static_assert(sizeof(dtype_scale) == 2, "scale must be 16-bit float");

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

    static constexpr uint32_t tile_size_x_a = k_stride;
    static constexpr uint32_t tile_size_y_a = sg_tile_m;
    static constexpr uint32_t block_size_x_a
            = compute_policy::block_bytes_x_a / sizeof(dtype_a);
    static constexpr uint32_t block_size_y_a
            = (compute_policy::block_size_y_a > sg_tile_m)
            ? sg_tile_m
            : compute_policy::block_size_y_a;

    static constexpr uint32_t tile_size_x_b = sg_tile_n;
    static constexpr uint32_t tile_size_y_b = k_stride;
    static constexpr uint32_t block_size_x_b = compute_policy::block_size_x_b;
    // one packed word per N-column holds 32 K-rows
    static constexpr uint32_t block_size_y_b_packed_words = 1;
    static constexpr uint32_t block_size_y_b_packed_fp16 = pack_ratio;
    // XMX consumes 16 fp16 K-rows per block
    static constexpr uint32_t block_size_y_b_acc = 16;

    static constexpr uint32_t tile_size_x_c = sg_tile_n;
    static constexpr uint32_t tile_size_y_c = sg_tile_m;

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

    using matB_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b,
            tile_size_y_b / pack_ratio, block_size_x_b,
            block_size_y_b_packed_words, reg_layout::tiled>;
    using matB_t = subgroup::tile_t<dtype_b, matB_tile_desc_t>;
    using matB_payload_t = subgroup::mem_payload_t<mem_desc_b_t,
            matB_tile_desc_t,
            subgroup::msg_type_v<matB_tile_desc_t, mem_space_b>, arch_tag>;
    using matB_prefetch_payload_t = subgroup::prefetch_payload_t<mem_desc_b_t,
            matB_tile_desc_t, wg_size_y, arch_tag>;

    using matB_acc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b,
            tile_size_y_b, block_size_x_b, block_size_y_b_acc,
            reg_layout::vnni_tiled>;
    using matB_acc_t = subgroup::tile_t<dtype_mma_b, matB_acc_tile_desc_t>;

public:
    static_assert((k_stride % block_size_y_b_acc == 0),
            "k_stride must be a multiple of the XMX K-block (16 fp16)");
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

    using matAcc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_c,
            tile_size_y_c, block_size_x_b, block_size_y_a, reg_layout::tiled>;
    using matAcc_t = subgroup::tile_t<dtype_mma_acc, matAcc_tile_desc_t>;

private:
    using scale_tile_desc_t
            = subgroup::tile_desc_t<tile_size_x_b, tile_size_y_scale,
                    block_size_x_b, block_size_y_scale, reg_layout::tiled>;
    using scale_t = subgroup::tile_t<dtype_scale, scale_tile_desc_t>;
    using scale_payload_t
            = subgroup::mem_payload_t<mem_desc_scale_t, scale_tile_desc_t,
                    subgroup::msg_type_v<scale_tile_desc_t, mem_space::global>,
                    arch_tag>;
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
#ifdef BITCOS_SHARE_LUT_SLM
        static constexpr bool share_slm_across_kslices = true;
#else
        static constexpr bool share_slm_across_kslices = false;
#endif
    static constexpr uint32_t barrier_count
                        = enable_periodic_sync ? barrier_count_x + barrier_count_y
#ifdef BITCOS_FP16_LUT
                                                                   : barrier_count_y;
#else
                                                                   : 0;
#endif
#ifdef BITCOS_FP16_LUT
#ifdef BITCOS_INT8_LUT
    static constexpr uint32_t slm_size = 256 * 4 + 128;
#elif defined(BITCOS_LUT_STRIDE12)
    static constexpr uint32_t slm_size = 256 * 12 + 128;
#else
    static constexpr uint32_t slm_size = 256 * 8 + 128;
#endif
#else
    static constexpr uint32_t slm_size = 0;
#endif

    static constexpr msg_type msg_type_a = matA_payload_t::message_type;
    static constexpr msg_type msg_type_b = matB_payload_t::message_type;

    /// @brief Arguments for gemm.
    /// `signs_base` and `offsets_base` point into the same allocation as
    /// matB_base_desc; the caller derives them from (K, N).
    struct arguments_t {
        mem_desc_a_t matA_base_desc;
        mem_desc_b_t matB_base_desc;
        uint32_t inner_loop_count;
        mem_desc_scale_t scale_base_desc;
        uint32_t *signs_base;
        uint32_t *offsets_base;
        uint32_t *initial_ranks_base;

        inline arguments_t() = default;

        inline arguments_t(mem_desc_a_t matA_desc, mem_desc_b_t matB_desc,
                uint32_t loop_count, mem_desc_scale_t scale_desc,
                uint32_t *signs, uint32_t *offsets,
                uint32_t *initial_ranks = nullptr)
            : matA_base_desc(matA_desc)
            , matB_base_desc(matB_desc)
            , inner_loop_count(loop_count)
            , scale_base_desc(scale_desc)
            , signs_base(signs)
            , offsets_base(offsets)
            , initial_ranks_base(initial_ranks) {}

        inline arguments_t(const arguments_t &args) = default;
        inline arguments_t &operator=(const arguments_t &args) = default;
    };

    __XETLA_API static void release(uint8_t nbarrier_id = 0) {
        static constexpr bool need_local_fence = false;
        if constexpr (need_local_fence) { xetla_fence<memory_kind::shared_local>(); }
        xetla_nbarrier_t<wg_size_x, wg_size_x, arch_tag> nbarrier;
        nbarrier.init_nbarrier(nbarrier_id, nbarrier_role::producer_consumer);
        nbarrier.arrive_wait();
    }

    __XETLA_API KERNEL_FUNC void operator()(work_group_t &g, matAcc_t &matAcc,
            arguments_t args, [[maybe_unused]] uint32_t slm_base = 0,
            uint32_t nbarrier_base = 0) {
        int32_t sg_idx = g.get_id() % wg_size_x;
        int32_t sg_idy = g.get_id() / wg_size_x;
        // capture the subgroup's first global column before the descriptor is
        // advanced, so the per-column sign offsets can be indexed
        const uint32_t sg_col0
                = args.matB_base_desc.coord.x + sg_idx * sg_tile_n;
        update_sg_tile_tdesc(args, sg_idx, sg_idy);

        matA_t matA;
        matB_t matB;
        scale_t scale;

        matA_payload_t matA_payload(args.matA_base_desc);
        matB_payload_t matB_payload(args.matB_base_desc);
        scale_payload_t scale_payload(args.scale_base_desc);
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

        // per-column sign-stream state, carried across the whole k loop
        xetla_vector<uint32_t, tile_size_x_b> col_off;
        xetla_vector<uint32_t, tile_size_x_b> rank;
        {
            xetla_vector<uint32_t, tile_size_x_b> lane_idx
                    = xetla_vector_gen<uint32_t, tile_size_x_b>(0, 1);
            xetla_vector<uint32_t, tile_size_x_b> byte_off
                    = (lane_idx + sg_col0) << 2;
            col_off = xetla_load_global<uint32_t, 1, data_size::default_size,
                    cache_hint::cached, cache_hint::cached, tile_size_x_b>(
                    args.offsets_base, byte_off);
                        if (args.initial_ranks_base) {
                                rank = xetla_load_global<uint32_t, 1,
                                                data_size::default_size, cache_hint::cached,
                                                cache_hint::cached, tile_size_x_b>(
                                                args.initial_ranks_base, byte_off);
                        } else {
                                rank = 0;
                        }
        }

#ifdef BITCOS_FP16_LUT
                build_lut(sg_idx, slm_base);
        if constexpr (wg_size_x > 1) {
                        xetla_fence<memory_kind::shared_local>();
            nbarrier_a.arrive();
            nbarrier_a.wait();
        }
        xetla_vector<uint32_t, block_size_x_b> c_idx
                = xetla_load_local<uint32_t, block_size_x_b>(
                        slm_base + kMaskIdxOff);
        xetla_vector<uint32_t, block_size_x_b> c_wp
                = xetla_load_local<uint32_t, block_size_x_b>(
                        slm_base + kMaskWpOff);
#endif

        int scale_prefetch_addr_i = 0;
        int scale_load_addr_i = 0;
        SW_BARRIER();
#pragma unroll
        for (uint32_t i = 0; i < stages; i++) {
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                    matA_prefetch_payload);
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                    matB_prefetch_payload);
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
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(
                    matB, matB_payload);
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(
                    scale, scale_payload);
            scale_load_addr_i++;
            SW_BARRIER();
            if constexpr (stages != 0) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                        matA_prefetch_payload);
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                        matB_prefetch_payload);
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(
                        scale_prefetch_payload);
                scale_prefetch_addr_i++;
            }
            SW_BARRIER();
#ifdef BITCOS_ALU_ONLY
            // Walk a 4-tile window instead of streaming K: addresses still
            // change every iteration so nothing is loop invariant and no load
            // can be hoisted, but the working set stays in L1. Results are
            // wrong by construction; this measures unpack throughput.
            matA_payload.template update_tdesc<update_dir_a>(
                    (i & 3) == 3 ? -3 * int(matA_t::tile_size_x)
                                 : int(matA_t::tile_size_x));
            matB_payload.template update_tdesc<update_dir_b>(
                    (i & 3) == 3 ? -3 * int(matB_t::tile_size_y)
                                 : int(matB_t::tile_size_y));
#else
            matA_payload.template update_tdesc<update_dir_a>(
                    matA_t::tile_size_x);
            matB_payload.template update_tdesc<update_dir_b>(
                    matB_t::tile_size_y);
#endif
            if ((scale_load_addr_i % scale_addr_update_freq) == 0) {
                scale_payload.template update_tdesc<tdesc_update_dir::y_dir>(
                        scale_t::tile_size_y);
            }
            if constexpr (stages != 0) {
#ifdef BITCOS_ALU_ONLY
                // pin the prefetchers too, or they keep streaming all of B
                matA_prefetch_payload.template update_tdesc<update_dir_a>(
                        (i & 3) == 3 ? -3 * int(matA_t::tile_size_x)
                                     : int(matA_t::tile_size_x));
                matB_prefetch_payload.template update_tdesc<update_dir_b>(
                        (i & 3) == 3 ? -3 * int(matB_t::tile_size_y)
                                     : int(matB_t::tile_size_y));
#else
                matA_prefetch_payload.template update_tdesc<update_dir_a>(
                        matA_t::tile_size_x);
                matB_prefetch_payload.template update_tdesc<update_dir_b>(
                        matB_t::tile_size_y);
#endif
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
#ifdef BITCOS_FP16_LUT
            dequantize(matB_acc, matB, scale, args.signs_base, col_off, rank,
                    c_idx, c_wp, slm_base);
#else
            dequantize(matB_acc, matB, scale, args.signs_base, col_off, rank);
#endif
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
    /// Population count of a u32 lane vector; Xe has no cbit wrapper in XeTLA.
    template <uint32_t N>
    __XETLA_API static xetla_vector<uint32_t, N> popcount_u32(
            xetla_vector<uint32_t, N> v) {
        v = v - ((v >> 1) & uint32_t(0x55555555u));
        v = (v & uint32_t(0x33333333u)) + ((v >> 2) & uint32_t(0x33333333u));
        v = (v + (v >> 4)) & uint32_t(0x0F0F0F0Fu);
        return (v * uint32_t(0x01010101u)) >> 24;
    }

#ifdef BITCOS_FP16_LUT
#ifdef BITCOS_INT8_LUT
        static constexpr uint32_t kEntryBytes = 4;
        static constexpr uint32_t kIdxMask = 0x3C0u;
        static constexpr uint32_t kWpMask = 0x3Cu;
        static constexpr uint32_t kNibbleShift = 6;
#elif defined(BITCOS_LUT_STRIDE12)
    // SLM is 16 banks x 4 B, so bank = (addr/4) % 16. With 8 B entries the
    // address is 128*m4 + 8*s4, the m4 term vanishes mod 16, and bank = 2*s4
    // reaches only the 8 even banks. Padding to 12 B makes bank = 3*s4, and
    // gcd(3,16)=1 so it is a bijection onto all 16.
    static constexpr uint32_t kEntryBytes = 12;
    static constexpr uint32_t kIdxMask = 0xF0u; // m4 at index bits 4..7
    static constexpr uint32_t kWpMask = 0x0Fu;  // s4 at index bits 0..3
    static constexpr uint32_t kNibbleShift = 4;
#else
    static constexpr uint32_t kEntryBytes = 8;
    static constexpr uint32_t kIdxMask = 0x780u; // m4 at byte-offset bits 7..10
    static constexpr uint32_t kWpMask = 0x78u;   // s4 at byte-offset bits 3..6
    static constexpr uint32_t kNibbleShift = 7;
#endif
    static constexpr uint32_t kLutBytes = 256 * kEntryBytes;
    static constexpr uint32_t kMaskIdxOff = kLutBytes;
    static constexpr uint32_t kMaskWpOff = kLutBytes + 64;

public:
    static constexpr uint32_t slm_size_lut = kLutBytes + 128;

private:
    /// Four fp16 ternary codes keyed by (bitmap nibble, next four sign bits).
    ///
    /// This is the pdep the format needs, plus the magnitude and the sign, in
    /// one gather. A multiply against the column scale needs only this single
    /// 16-bit field per weight, whereas the (scale ^ sgn) & mag trick needs two
    /// fields and so cannot share a gather. It also lands on the float pipe,
    /// which the all-integer unpack leaves idle.
    ///
        __XETLA_API static void build_lut(uint32_t sg_idx, uint32_t slm_base) {
        xetla_vector<uint32_t, 16> lane = xetla_vector_gen<uint32_t, 16>(0, 1);
#pragma unroll
                for (uint32_t base = sg_idx * 16; base < 256;
                                base += wg_size_x * 16) {
            xetla_vector<uint32_t, 16> idx = lane + base;
            xetla_vector<uint32_t, 16> m4 = idx >> 4;
            xetla_vector<uint32_t, 16> s4 = idx & uint32_t(15u);
            xetla_vector<uint32_t, 16> pres[4];
            pres[0] = m4 & uint32_t(1u);
            pres[1] = (m4 >> 1) & uint32_t(1u);
            pres[2] = (m4 >> 2) & uint32_t(1u);
            pres[3] = (m4 >> 3) & uint32_t(1u);
            xetla_vector<uint32_t, 16> rk[4];
            rk[0] = uint32_t(0);
            rk[1] = pres[0];
            rk[2] = pres[0] + pres[1];
            rk[3] = pres[0] + pres[1] + pres[2];
            xetla_vector<uint32_t, 16> code[4];
#pragma unroll
            for (uint32_t t = 0; t < 4; ++t) {
                xetla_vector<uint32_t, 16> neg
                        = (s4 >> rk[t]) & uint32_t(1u);
#ifdef BITCOS_INT8_LUT
                code[t] = (uint32_t(1u) | (uint32_t(0) - neg))
                        & (uint32_t(0) - pres[t]);
#else
                code[t] = (uint32_t(0x3C00u) | (neg << 15))
                        & (uint32_t(0) - pres[t]);
#endif
            }
            xetla_vector<uint32_t, 16> off
                    = idx * uint32_t(kEntryBytes) + slm_base;
#ifdef BITCOS_INT8_LUT
            xetla_vector<uint32_t, 16> d0 = code[0] | (code[1] << 8)
                    | (code[2] << 16) | (code[3] << 24);
            xetla_store_local<uint32_t, 1>(off, d0);
#else
            xetla_vector<uint32_t, 16> d0 = code[0] | (code[1] << 16);
            xetla_vector<uint32_t, 16> d1 = code[2] | (code[3] << 16);
#ifdef BITCOS_LUT_EMBED_COUNT
            xetla_vector<uint32_t, 16> count
                    = pres[0] + pres[1] + pres[2] + pres[3];
            d0 = d0 | count;
#endif
            xetla_store_local<uint32_t, 1>(off, d0);
            xetla_store_local<uint32_t, 1>(off + 4, d1);
#endif
        }
        // The index masks live in SLM so IGC cannot see that they fit in 16
        // bits: as immediates it narrows the chain to :w and spends three movs
        // per group repacking stride-2 words back to dwords.
                if (sg_idx == 0) {
                        xetla_vector<uint32_t, 16> moff
                                    = (lane << 2) + slm_base + uint32_t(kMaskIdxOff);
                        xetla_vector<uint32_t, 16> vi = uint32_t(kIdxMask);
                        xetla_vector<uint32_t, 16> vw = uint32_t(kWpMask);
                        xetla_store_local<uint32_t, 1>(moff, vi);
                        xetla_store_local<uint32_t, 1>(moff + 64, vw);
                }
    }
#endif

    /// Unpack one BITCOS matB tile into an fp16 VNNI-2 tile with the per-K-group
    /// scale applied.
    ///
    /// Per weight, with `w` the per-lane sign window:
    ///   present  = (bmp >> c) & 1;      mag_mask = 0 - present
    ///   sign_xor = (w & 1) << 15
    ///   out      = (scale ^ sign_xor) & mag_mask
    ///   w      >>= present
    /// The 0/1 shift consumes a sign bit only where one exists, which is what
    /// removes the need for pdep. Absent lanes emit exact +0.
    inline void dequantize(matB_acc_t &matB_acc, matB_t &matB, scale_t &scale,
            uint32_t *signs_base, xetla_vector<uint32_t, tile_size_x_b> &col_off,
            xetla_vector<uint32_t, tile_size_x_b> &rank
#ifdef BITCOS_FP16_LUT
            ,
            xetla_vector<uint32_t, block_size_x_b> &c_idx,
            xetla_vector<uint32_t, block_size_x_b> &c_wp,
            uint32_t slm_base
#endif
    ) {
        constexpr uint32_t num_block_x = tile_size_x_b / block_size_x_b;
        constexpr uint32_t num_packed_block_y
                = (tile_size_y_b / pack_ratio) / block_size_y_b_packed_words;
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
                "bitmap block must hold exactly BSX uint32 words");

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
                // the whole unpack runs in dword lanes to match the sign
                // window; mixing u16 and u32 costs a pack/unpack mov per step
                xetla_vector<uint32_t, BSX> scale32 = scale_u16;

                auto off_j = col_off.xetla_select<BSX, 1>(j * BSX);
                auto rank_j = rank.xetla_select<BSX, 1>(j * BSX);

                // A gather address depends on rank, and rank depends on the
                // popcount of the current bitmap word, so gathering per row
                // puts one memory latency per row on the critical path. The
                // ranks only need the already loaded bitmap, so resolve them
                // all first and let the gathers overlap.
                xetla_vector<uint32_t, BSX> w_all[packed_per_scale];
                {
                    xetla_vector<uint32_t, BSX> rank_ii[packed_per_scale];
                    xetla_vector<uint32_t, BSX> r = rank_j;
#pragma unroll
                    for (uint32_t ii = 0; ii < packed_per_scale; ++ii) {
                        rank_ii[ii] = r;
                        auto bmp_ii
                                = matB.reg
                                          .xetla_select<matB_t::block_elems, 1>(
                                                  ((g_ * packed_per_scale + ii)
                                                                  * num_block_x
                                                          + j)
                                                  * matB_t::block_elems)
                                          .xetla_format<uint32_t>();
                        r = r + popcount_u32<BSX>(bmp_ii);
                    }
                    rank_j = r;
#ifdef BITCOS_SIGN_GATHER4
                    // A 32-row block advances rank by at most 32 bits, so each
                    // successive block's word index moves by at most one. With
                    // two blocks the union of both windows spans words 0..2, so
                    // a single d32x4 at block 0's address provably covers both
                    // and the per-block pick is a 1-bit select. Blocks past the
                    // second would need words beyond the quad, so they keep the
                    // narrow path.
                    if constexpr (packed_per_scale <= 2) {
                    xetla_vector<uint32_t, BSX> word0 = rank_ii[0] >> 5;
                    xetla_vector<uint32_t, BSX> quad_off = (off_j + word0) << 2;
#ifdef BITCOS_ALU_ONLY
                    quad_off = quad_off & uint32_t(0x3FFFu);
#endif
                    xetla_vector<uint32_t, 4 * BSX> quad
                            = xetla_load_global<uint32_t, 4,
                                    data_size::default_size, cache_hint::cached,
                                    cache_hint::cached, BSX>(
                                    signs_base, quad_off);
                    xetla_vector<uint32_t, BSX> q0
                            = quad.xetla_select<BSX, 1>(0);
                    xetla_vector<uint32_t, BSX> q1
                            = quad.xetla_select<BSX, 1>(BSX);
                    xetla_vector<uint32_t, BSX> q2
                            = quad.xetla_select<BSX, 1>(2 * BSX);
                    using bfn_sel_t = sycl::ext::intel::esimd::bfn_t;
                    constexpr bfn_sel_t pick
                            = (bfn_sel_t::x & ~bfn_sel_t::z)
                            | (bfn_sel_t::y & bfn_sel_t::z);
#pragma unroll
                    for (uint32_t ii = 0; ii < packed_per_scale; ++ii) {
                        xetla_vector<uint32_t, BSX> m
                                = uint32_t(0) - ((rank_ii[ii] >> 5) - word0);
                        xetla_vector<uint32_t, BSX> lo
                                = sycl::ext::intel::esimd::bfn<pick>(q0, q1, m);
                        xetla_vector<uint32_t, BSX> hi
                                = sycl::ext::intel::esimd::bfn<pick>(q1, q2, m);
                        xetla_vector<uint32_t, BSX> sh
                                = rank_ii[ii] & uint32_t(31u);
                        xetla_vector<uint32_t, BSX> shn
                                = (uint32_t(32u) - sh) & uint32_t(31u);
                        xetla_vector<uint32_t, BSX> keep
                                = uint32_t(0) - ((uint32_t(0) - sh) >> 31);
                        w_all[ii] = (lo >> sh) | ((hi << shn) & keep);
                    }
                    } else
#endif
                    {
#pragma unroll
                    for (uint32_t ii = 0; ii < packed_per_scale; ++ii) {
                        xetla_vector<uint32_t, BSX> word_off
                                = (off_j + (rank_ii[ii] >> 5)) << 2;
#ifdef BITCOS_ALU_ONLY
                        // per-lane addresses still diverge, but within 16 KB
                        word_off = word_off & uint32_t(0x3FFFu);
#endif
#ifdef BITCOS_SIGN_GATHER2
                        // lo and hi are adjacent dwords, so one d32x2 message
                        // fetches both: same bytes, half the messages. The
                        // prefetch experiment showed these gathers are bound by
                        // message throughput, not latency.
                        xetla_vector<uint32_t, 2 * BSX> lohi
                                = xetla_load_global<uint32_t, 2,
                                        data_size::default_size,
                                        cache_hint::cached, cache_hint::cached,
                                        BSX>(signs_base, word_off);
                        xetla_vector<uint32_t, BSX> lo
                                = lohi.xetla_select<BSX, 1>(0);
                        xetla_vector<uint32_t, BSX> hi
                                = lohi.xetla_select<BSX, 1>(BSX);
#else
                        xetla_vector<uint32_t, BSX> lo
                                = xetla_load_global<uint32_t, 1,
                                        data_size::default_size,
                                        cache_hint::cached, cache_hint::cached,
                                        BSX>(signs_base, word_off);
                        xetla_vector<uint32_t, BSX> hi
                                = xetla_load_global<uint32_t, 1,
                                        data_size::default_size,
                                        cache_hint::cached, cache_hint::cached,
                                        BSX>(signs_base, word_off + 4);
#endif
#ifdef BITCOS_SIGN_PREFETCH
                        // Measured pessimization, kept only to document it.
                        // Each lane walks its own column's sign run and advances
                        // ~1.2 words per k-tile, so this looked like a latency
                        // problem, but time degrades in proportion to the
                        // distance (0.322 -> 0.367 -> 0.436 -> 0.451 ms at
                        // 64/128/256 B). The gathers are LSU-throughput bound,
                        // not latency bound: the prefetch is itself a 16-address
                        // scattered message competing for the same issue slots.
                        // The lever is fewer gathers, not earlier ones.
                        xetla_prefetch_global<uint32_t, 1,
                                data_size::default_size, cache_hint::cached,
                                cache_hint::cached, BSX>(signs_base,
                                word_off + uint32_t(BITCOS_SIGN_PREFETCH));
#endif
                        xetla_vector<uint32_t, BSX> sh
                                = rank_ii[ii] & uint32_t(31u);
                        // sh == 0 must contribute nothing from the high word;
                        // a 32-wide shift would be undefined, so mask instead.
                        xetla_vector<uint32_t, BSX> shn
                                = (uint32_t(32u) - sh) & uint32_t(31u);
                        xetla_vector<uint32_t, BSX> keep
                                = uint32_t(0) - ((uint32_t(0) - sh) >> 31);
                        w_all[ii] = (lo >> sh) | ((hi << shn) & keep);
                    }
                    }
                }

#pragma unroll
                for (uint32_t ii = 0; ii < packed_per_scale; ++ii) {
                    const uint32_t i_pk = g_ * packed_per_scale + ii;
                    const int packed_block_id = i_pk * num_block_x + j;
                    xetla_vector<uint32_t, BSX> bmp
                            = matB.reg
                                      .xetla_select<matB_t::block_elems, 1>(
                                              packed_block_id
                                              * matB_t::block_elems)
                                      .xetla_format<uint32_t>();
                    xetla_vector<uint32_t, BSX> w = w_all[ii];
                    auto dst_lo = matB_acc.reg.xetla_select<
                            matB_acc_t::block_elems, 1>(
                            (i_pk * 2u + 0u) * num_block_x
                                            * matB_acc_t::block_elems
                                    + j * matB_acc_t::block_elems);
                    auto dst_hi = matB_acc.reg.xetla_select<
                            matB_acc_t::block_elems, 1>(
                            (i_pk * 2u + 1u) * num_block_x
                                            * matB_acc_t::block_elems
                                    + j * matB_acc_t::block_elems);
                    auto dst_lo_u16 = dst_lo.xetla_format<uint16_t>();
                    auto dst_hi_u16 = dst_hi.xetla_format<uint16_t>();
                    using bfn_t = sycl::ext::intel::esimd::bfn_t;
                    constexpr bfn_t make_value
                            = (bfn_t::x ^ bfn_t::y) & bfn_t::z;
                    constexpr bfn_t advance_signs
                            = (bfn_t::x & bfn_t::z)
                            | (bfn_t::y & ~bfn_t::z);
                    xetla_vector<uint32_t, BSX> bf_width = uint32_t(1u);

#ifdef BITCOS_FP16_LUT
                    constexpr bfn_t merge_masked
                            = (bfn_t::x & bfn_t::y) | bfn_t::z;
                    auto dst_lo_u32 = dst_lo.xetla_format<uint32_t>();
                    auto dst_hi_u32 = dst_hi.xetla_format<uint32_t>();
#ifdef BITCOS_PREFIX_SIGN_OFFSETS
                    xetla_vector<uint32_t, BSX> w_group[2 * BSY_acc / 4];
                    w_group[0] = w;
#pragma unroll
                    for (uint32_t pg = 1; pg < 2 * BSY_acc / 4; ++pg) {
                        const uint32_t prefix_mask
                                = (uint32_t(1) << (pg * 4)) - 1;
                        xetla_vector<uint32_t, BSX> prefix
                                = bmp & uint32_t(prefix_mask);
                        w_group[pg]
                                = w >> sycl::ext::intel::esimd::cbit(prefix);
                    }
#endif
#ifdef BITCOS_SPLIT_SIGN_CHAIN
                    xetla_vector<uint32_t, BSX> w_chain[2];
                    w_chain[0] = w;
                    xetla_vector<uint32_t, BSX> bmp_lo16
                            = bmp & uint32_t(0xFFFFu);
                    w_chain[1] = w >> sycl::ext::intel::esimd::cbit(bmp_lo16);
#endif
                    // a 2-element gather returns transposed data, so the scale
                    // repeats per dword half rather than per lane group
                    xetla_vector<fp16, 4 * BSX> sc_rep;
#ifdef BITCOS_INT8_LUT
                    sc_rep.xetla_select<BSX, 4>(0) = scale_vec;
                    sc_rep.xetla_select<BSX, 4>(1) = scale_vec;
                    sc_rep.xetla_select<BSX, 4>(2) = scale_vec;
                    sc_rep.xetla_select<BSX, 4>(3) = scale_vec;
#else
                    sc_rep.xetla_select<BSX, 2>(0) = scale_vec;
                    sc_rep.xetla_select<BSX, 2>(1) = scale_vec;
                    sc_rep.xetla_select<BSX, 2>(2 * BSX) = scale_vec;
                    sc_rep.xetla_select<BSX, 2>(2 * BSX + 1) = scale_vec;
#endif
#pragma unroll
                    for (uint32_t g = 0; g < 2 * BSY_acc / 4; ++g) {
                        constexpr uint32_t kGroups = 2 * BSY_acc / 4;
                        const uint32_t bpos = g * 4;
#ifdef BITCOS_PREFIX_SIGN_OFFSETS
                        auto &w_cur = w_group[g];
#elif defined(BITCOS_SPLIT_SIGN_CHAIN)
                                                auto &w_cur = w_chain[g / (kGroups / 2)];
#else
                                                auto &w_cur = w;
#endif
                        // land the bitmap nibble on the index bits the entry
                        // stride expects; one of the two shifts folds away
                        const uint32_t sl = (bpos <= kNibbleShift)
                                ? (kNibbleShift - bpos)
                                : 0u;
                        const uint32_t sr = (bpos <= kNibbleShift)
                                ? 0u
                                : (bpos - kNibbleShift);
                        xetla_vector<uint32_t, BSX> tsh = (bmp << sl) >> sr;
#ifdef BITCOS_INT8_LUT
                        xetla_vector<uint32_t, BSX> wp = (w_cur << 2) & c_wp;
#elif defined(BITCOS_LUT_STRIDE12)
                        xetla_vector<uint32_t, BSX> wp = w_cur & c_wp;
#else
                        xetla_vector<uint32_t, BSX> wp = (w_cur << 3) & c_wp;
#endif
#ifndef BITCOS_LUT_EMBED_COUNT
                        xetla_vector<uint32_t, BSX> m4 = tsh & c_idx;
#endif
                        xetla_vector<uint32_t, BSX> off
                                = sycl::ext::intel::esimd::bfn<merge_masked>(
                                        tsh, c_idx, wp);
#ifdef BITCOS_LUT_STRIDE12
                        off = off * uint32_t(kEntryBytes);
#endif
#ifdef BITCOS_INT8_LUT
                        xetla_vector<uint32_t, BSX> e
                                = xetla_load_local<uint32_t, 1>(off + slm_base);
                        xetla_vector<int8_t, 4 * BSX> code_i8
                                = e.xetla_format<int8_t>();
                        xetla_vector<fp16, 4 * BSX> code = code_i8;
#else
                        xetla_vector<uint32_t, 2 * BSX> e
                                = xetla_load_local<uint32_t, 2>(off + slm_base);
#ifdef BITCOS_LUT_EMBED_COUNT
                        xetla_vector<uint32_t, BSX> count
                                = e.xetla_select<BSX, 1>(0) & uint32_t(7u);
                        e.xetla_select<BSX, 1>(0)
                                = e.xetla_select<BSX, 1>(0)
                                & uint32_t(0xFFFFFFF8u);
#endif
                        xetla_vector<fp16, 4 * BSX> code
                                = e.xetla_format<fp16>();
#endif
                        xetla_vector<fp16, 4 * BSX> v = code * sc_rep;
                        auto vd = v.xetla_format<uint32_t>();
                        const uint32_t o = (g % (kGroups / 2)) * 2 * BSX;
                        if (g < kGroups / 2) {
#ifdef BITCOS_INT8_LUT
                            dst_lo_u32.xetla_select<BSX, 1>(o)
                                    = vd.xetla_select<BSX, 2>(0);
                            dst_lo_u32.xetla_select<BSX, 1>(o + BSX)
                                    = vd.xetla_select<BSX, 2>(1);
#else
                            dst_lo_u32.xetla_select<BSX, 1>(o)
                                    = vd.xetla_select<BSX, 1>(0);
                            dst_lo_u32.xetla_select<BSX, 1>(o + BSX)
                                    = vd.xetla_select<BSX, 1>(BSX);
#endif
                        } else {
#ifdef BITCOS_INT8_LUT
                            dst_hi_u32.xetla_select<BSX, 1>(o)
                                    = vd.xetla_select<BSX, 2>(0);
                            dst_hi_u32.xetla_select<BSX, 1>(o + BSX)
                                    = vd.xetla_select<BSX, 2>(1);
#else
                            dst_hi_u32.xetla_select<BSX, 1>(o)
                                    = vd.xetla_select<BSX, 1>(0);
                            dst_hi_u32.xetla_select<BSX, 1>(o + BSX)
                                    = vd.xetla_select<BSX, 1>(BSX);
#endif
                        }
#ifndef BITCOS_PREFIX_SIGN_OFFSETS
#ifdef BITCOS_LUT_EMBED_COUNT
                        w_cur = w_cur >> count;
#else
                                                w_cur = w_cur >> sycl::ext::intel::esimd::cbit(m4);
#endif
#endif
                    }
#else
#pragma unroll
                    for (uint32_t c = 0; c < BSY_acc; ++c) {
                        xetla_vector<uint32_t, BSX> bf_offset = c;
                        xetla_vector<uint32_t, BSX> mag_mask
                                = __esimd_sbfe<uint32_t, BSX>(bf_width.data(),
                                        bf_offset.data(), bmp.data());
                        xetla_vector<uint32_t, BSX> sign_xor = w << 15;
                        xetla_vector<uint32_t, BSX> result
                                = sycl::ext::intel::esimd::bfn<make_value>(
                                        scale32, sign_xor, mag_mask);
#ifdef BITCOS_FP_STORE
                        // identical mov, but :hf data issues on the float pipe,
                        // which the all-integer unpack otherwise leaves idle
                        dst_lo.xetla_select<BSX, 2>(
                                (c >> 1) * 2u * BSX + (c & 1u))
                                = result.xetla_format<fp16>()
                                          .xetla_select<BSX, 2>(0);
#else
                        dst_lo_u16.xetla_select<BSX, 2>(
                                (c >> 1) * 2u * BSX + (c & 1u))
                                = result;
#endif
                        xetla_vector<uint32_t, BSX> w_shifted = w >> 1;
                        w = sycl::ext::intel::esimd::bfn<advance_signs>(
                                w_shifted, w, mag_mask);
                    }
#pragma unroll
                    for (uint32_t c = 0; c < BSY_acc; ++c) {
                        xetla_vector<uint32_t, BSX> bf_offset = c + BSY_acc;
                        xetla_vector<uint32_t, BSX> mag_mask
                                = __esimd_sbfe<uint32_t, BSX>(bf_width.data(),
                                        bf_offset.data(), bmp.data());
                        xetla_vector<uint32_t, BSX> sign_xor = w << 15;
                        xetla_vector<uint32_t, BSX> result
                                = sycl::ext::intel::esimd::bfn<make_value>(
                                        scale32, sign_xor, mag_mask);
#ifdef BITCOS_FP_STORE
                        dst_hi.xetla_select<BSX, 2>(
                                (c >> 1) * 2u * BSX + (c & 1u))
                                = result.xetla_format<fp16>()
                                          .xetla_select<BSX, 2>(0);
#else
                        dst_hi_u16.xetla_select<BSX, 2>(
                                (c >> 1) * 2u * BSX + (c & 1u))
                                = result;
#endif
                        xetla_vector<uint32_t, BSX> w_shifted = w >> 1;
                        w = sycl::ext::intel::esimd::bfn<advance_signs>(
                                w_shifted, w, mag_mask);
                    }
#endif
                }
                rank.xetla_select<BSX, 1>(j * BSX) = rank_j;
            }
        }
    }

    __XETLA_API static void update_sg_tile_tdesc(
            arguments_t &args, int32_t sg_idx, int32_t sg_idy) {
        int32_t tile_offset_n = sg_idx * sg_tile_n;
        int32_t tile_offset_m = sg_idy * sg_tile_m;
        args.matA_base_desc.update_coord_y(tile_offset_m);
        args.matB_base_desc.update_coord_x(tile_offset_n);
        args.scale_base_desc.update_coord_x(tile_offset_n);
    }
};

/// @} xetla_gemm

} // namespace gpu::xetla::group
