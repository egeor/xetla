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

#pragma once

#include "experimental/group/gemm/common.hpp"

namespace gpu::xetla::group {

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_, typename dtype_zero_pt_, int dequant_s_,
        gpu_arch arch_tag_ = gpu_arch::Xe>
struct compute_policy_int4_dequantize_xmx {};

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_, typename dtype_zero_pt_, int dequant_s_>
struct compute_policy_int4_dequantize_xmx<compute_attr_, perf_tuning_knob_,
        dtype_scale_, dtype_zero_pt_, dequant_s_, gpu_arch::Xe> {
    using compute_attr = compute_attr_;
    using perf_tuning_knob = perf_tuning_knob_;
    static constexpr int k_stride = perf_tuning_knob::k_stride;
    static constexpr int stages = perf_tuning_knob::stages;
    static constexpr int sync_freq = perf_tuning_knob::sync_freq;
    static constexpr gpu_arch arch_tag = gpu_arch::Xe;
    using dtype_mma_acc = typename compute_attr::dtype_acc;
    using dtype_mma_a = typename compute_attr::dtype_a;
    using dtype_mma_b = typename compute_attr::dtype_b;

    static constexpr uint32_t block_bytes_x_a = 32;
    static constexpr uint32_t block_size_y_a = 16;

    static constexpr bool is_int4_matB_policy = true;

    static constexpr uint32_t block_size_x_b = 16;
    static constexpr uint32_t block_bytes_y_b = 32;
    static_assert(block_bytes_x_a == block_bytes_y_b,
            "mat_a x need to match with mat_b y");

    static constexpr uint32_t dequant_s = dequant_s_;
    static_assert((dequant_s % (32 / sizeof(dtype_mma_b))) == 0,
            "dequant_s should be a multiply of 32B");
    using dtype_scale = dtype_scale_;
    using dtype_zero_pt = dtype_zero_pt_;
};

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_a_, typename dtype_scale_b_, int mma_xmx_m_ = 0,
        gpu_arch arch_tag_ = gpu_arch::Xe>
struct compute_policy_int2_bf16_dpas_xmx {};

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_a_, typename dtype_scale_b_, int mma_xmx_m_>
struct compute_policy_int2_bf16_dpas_xmx<compute_attr_, perf_tuning_knob_,
        dtype_scale_a_, dtype_scale_b_, mma_xmx_m_, gpu_arch::Xe> {
    using compute_attr = compute_attr_;
    using perf_tuning_knob = perf_tuning_knob_;
    static constexpr int k_stride = perf_tuning_knob::k_stride;
    static constexpr int stages = perf_tuning_knob::stages;
    static constexpr int sync_freq = perf_tuning_knob::sync_freq;
    static constexpr gpu_arch arch_tag = gpu_arch::Xe;
    using dtype_mma_acc = typename compute_attr::dtype_acc;
    using dtype_mma_a = int8_t;
    using dtype_mma_b = int2x16;

    static constexpr uint32_t block_bytes_x_a = 32;
    static constexpr uint32_t block_size_y_a = 16;

    static constexpr bool is_int2_bf16_dpas_policy = true;
    static constexpr bool is_int2_matB_policy = true;

    static constexpr uint32_t mma_xmx_m = static_cast<uint32_t>(mma_xmx_m_);
    using dtype_scale_a = dtype_scale_a_;
    using dtype_scale_b = dtype_scale_b_;

    static constexpr uint32_t block_size_x_b = 16;
    static constexpr uint32_t block_bytes_y_b = 32;
    static_assert(block_bytes_x_a == block_bytes_y_b,
            "mat_a x need to match with mat_b y");

    struct arch_attr {
        template <msg_type message_type = msg_type::block_2d>
        using load_store_attr = load_store_attr_t<message_type, gpu_arch::Xe>;

        template <grf_mode grf_num_mode = grf_mode::double_grf>
        using register_attr = register_attr_t<grf_num_mode, gpu_arch::Xe>;

        using mma_attr = mma_attr_t<gpu_arch::Xe, mma_xmx_m>;

        static constexpr uint32_t max_wg_num = 64;
    };
};

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_a_, typename dtype_scale_b_, int mma_xmx_m_ = 0,
        gpu_arch arch_tag_ = gpu_arch::Xe>
struct compute_policy_int2_fp16_dpas_xmx {};

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_a_, typename dtype_scale_b_, int mma_xmx_m_>
struct compute_policy_int2_fp16_dpas_xmx<compute_attr_, perf_tuning_knob_,
        dtype_scale_a_, dtype_scale_b_, mma_xmx_m_, gpu_arch::Xe> {
    using compute_attr = compute_attr_;
    using perf_tuning_knob = perf_tuning_knob_;
    static constexpr int k_stride = perf_tuning_knob::k_stride;
    static constexpr int stages = perf_tuning_knob::stages;
    static constexpr int sync_freq = perf_tuning_knob::sync_freq;
    static constexpr gpu_arch arch_tag = gpu_arch::Xe;
    using dtype_mma_acc = typename compute_attr::dtype_acc;
    using dtype_mma_a = int8_t;
    using dtype_mma_b = int2x16;

    static constexpr uint32_t block_bytes_x_a = 32;
    static constexpr uint32_t block_size_y_a = 16;

    static constexpr bool is_int2_fp16_dpas_policy = true;
    static constexpr bool is_int2_matB_policy = true;

    static constexpr uint32_t mma_xmx_m = static_cast<uint32_t>(mma_xmx_m_);
    using dtype_scale_a = dtype_scale_a_;
    using dtype_scale_b = dtype_scale_b_;

    static constexpr uint32_t block_size_x_b = 16;
    static constexpr uint32_t block_bytes_y_b = 32;
    static_assert(block_bytes_x_a == block_bytes_y_b,
            "mat_a x need to match with mat_b y");

    struct arch_attr {
        template <msg_type message_type = msg_type::block_2d>
        using load_store_attr = load_store_attr_t<message_type, gpu_arch::Xe>;

        template <grf_mode grf_num_mode = grf_mode::double_grf>
        using register_attr = register_attr_t<grf_num_mode, gpu_arch::Xe>;

        using mma_attr = mma_attr_t<gpu_arch::Xe, mma_xmx_m>;

        static constexpr uint32_t max_wg_num = 64;
    };
};

/// @brief Compute policy for int2 weight-only quantized GEMM with fp16 activations.
/// Activations stay in fp16 (no A quantization); int2 weights are upconverted to fp16
/// using a per-K-group fp16 scale, then fed to XMX as an fp16 x fp16 -> f32 GEMM.
/// No zero-points: int2 codes are interpreted as signed two's complement.
/// @tparam dequant_s_ K-group size (e.g. 128). Multiple of 16 (32B / sizeof(fp16)).
/// @tparam mma_xmx_m_ XMX `repeat_count` (M dim) for the DPAS instruction. 0
///                   means use the arch default (8). Use 1..7 for small-M GEMV
///                   shapes so that sg_tile_m == 1 still satisfies the
///                   tile_mma `tile_size_m % mma_m == 0` constraint.
/// @tparam use_unaligned_n_ When true, matB is loaded via per-row block_1d
///                          messages (one HW load per packed-K row) instead
///                          of a single block_2d descriptor. This drops the
///                          surface-pitch alignment requirement on matB so
///                          arbitrary `matrix_n` is supported with no
///                          driver-side padding. The caller is expected to
///                          pair this with `epilogue_policy_unaligned` for
///                          matC (default epilogue forces block_2d on matC).
template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_, int dequant_s_, int mma_xmx_m_ = 0,
        gpu_arch arch_tag_ = gpu_arch::Xe, bool use_unaligned_n_ = false>
struct compute_policy_int2_fp16_upcvt_xmx {};

template <typename compute_attr_, typename perf_tuning_knob_,
        typename dtype_scale_, int dequant_s_, int mma_xmx_m_,
        bool use_unaligned_n_>
struct compute_policy_int2_fp16_upcvt_xmx<compute_attr_, perf_tuning_knob_,
        dtype_scale_, dequant_s_, mma_xmx_m_, gpu_arch::Xe, use_unaligned_n_> {
    using compute_attr = compute_attr_;
    using perf_tuning_knob = perf_tuning_knob_;
    static constexpr int k_stride = perf_tuning_knob::k_stride;
    static constexpr int stages = perf_tuning_knob::stages;
    static constexpr int sync_freq = perf_tuning_knob::sync_freq;
    static constexpr gpu_arch arch_tag = gpu_arch::Xe;
    static constexpr bool use_unaligned_n = use_unaligned_n_;
    using dtype_mma_acc = typename compute_attr::dtype_acc; // float
    using dtype_mma_a = typename compute_attr::dtype_a;     // fp16
    using dtype_mma_b = typename compute_attr::dtype_b;     // fp16

    static constexpr uint32_t block_bytes_x_a = 32;
    static constexpr uint32_t block_size_y_a = 16;

    static constexpr bool is_int2_fp16_upcvt_policy = true;
    static constexpr bool is_int2_matB_policy = true;

    static constexpr uint32_t block_size_x_b = 16;
    static constexpr uint32_t block_bytes_y_b = 32;
    static_assert(block_bytes_x_a == block_bytes_y_b,
            "mat_a x need to match with mat_b y");

    static constexpr uint32_t dequant_s = dequant_s_;
    static_assert((dequant_s % (32 / sizeof(dtype_mma_b))) == 0,
            "dequant_s should be a multiple of 32B (== 16 fp16 elements)");
    using dtype_scale = dtype_scale_;

    static constexpr uint32_t mma_xmx_m = static_cast<uint32_t>(mma_xmx_m_);
    struct arch_attr {
        template <msg_type message_type = msg_type::block_2d>
        using load_store_attr = load_store_attr_t<message_type, gpu_arch::Xe>;

        template <grf_mode grf_num_mode = grf_mode::double_grf>
        using register_attr = register_attr_t<grf_num_mode, gpu_arch::Xe>;

        using mma_attr = mma_attr_t<gpu_arch::Xe, mma_xmx_m>;

        static constexpr uint32_t max_wg_num = 64;
    };
};

} // namespace gpu::xetla::group
