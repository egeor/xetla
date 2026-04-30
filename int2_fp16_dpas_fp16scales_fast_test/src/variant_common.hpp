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

#pragma once

#include <vector>
#include <functional>
#include <cstddef>
#include <cstdint>
#include <array>
#include <utility>
#include <cmath>
#include <random>
#include "xetla.hpp"  // Need this for types

using namespace gpu::xetla;
using namespace sycl;

#ifndef DEVICE_MEM_ALIGNMENT
#define DEVICE_MEM_ALIGNMENT 256
#endif

template <typename T>
T generate_real_random(T low, T high) {
    static thread_local ::std::mt19937 gen(::std::random_device{}());
    ::std::uniform_real_distribution<T> dist(low, high);
    return dist(gen);
}

inline float frcp(float x) { return (x == 0.0f) ? 0.0f : 1.0f / x; }

// Forward declarations for global variables defined in main.cpp
extern bool g_enable_validation;
extern size_t g_mat_m;
extern size_t g_mat_n;
extern size_t g_mat_k;
extern uint32_t g_global_kslicing;
extern uint32_t g_scale_gs;
extern uint32_t g_wg_m;
extern uint32_t g_sg_m;
extern uint32_t g_wg_n;
extern uint32_t g_sg_n;
extern uint32_t g_sg_k;
extern bool g_enable_bias;
extern bool g_enable_silu;
extern uint32_t g_external_scale_a_calc;

// Forward declarations for constants defined in main.cpp
extern int g_num_iters;  // Number of iterations (command-line argument)
extern int N_SETS;  // Not const because it's updated at runtime

// Forward declaration of the GEMM run function (implemented in main.cpp)
template <typename Test, bool EnableBias, bool EnableSiLU>
void int2_dequantize_gemm_run(int iter, int n_sets, bool enable_validation);

// Template base class for int2_dequant (must be in header for template instantiation)
template <uint32_t GKSlicing, uint32_t WgM = 64, uint32_t SgM = 64, uint32_t WgN = 128, uint32_t SgN = 16, uint32_t SgK = 32, uint32_t XMX_M = SgM, typename AccType = int32_t, typename CType = fp16, bool UseExternalScaleA = false>
class int2_dequant_base {
public:
    static size_t mat_m() { return g_mat_m; }
    static size_t mat_n() { return g_mat_n; }
    static size_t mat_k() { return g_mat_k; }
    static constexpr size_t wg_m = WgM;
    static constexpr size_t wg_n = WgN;
    static constexpr size_t sg_m = SgM;
    static constexpr size_t sg_n = SgN;
    static constexpr size_t sg_k = SgK;
    static constexpr uint32_t mma_xmx_m = XMX_M;
    static constexpr size_t num_buffer = 1;
    static constexpr size_t local_kslicing = 1;
    static constexpr size_t global_kslicing = GKSlicing;
    static constexpr size_t scale_gs = 1;
    static constexpr bool use_external_scale_a = UseExternalScaleA;
    
    using data_type_a = fp16;
    using data_type_b = int2x16;
    using data_type_c = CType;
    using data_type_acc = AccType;
};

// Dispatch function with external_scale_a_calc support - inline template to avoid multiple definitions.
// Both UseExternalScaleA={true,false} branches are now generated; the SLM
// scale_a path in the kslicing kernel was templated on dtype_scale_a so it
// also works for the fp16-scales variant.
template <typename TestBase, uint32_t GKS, uint32_t WgM, uint32_t SgM, uint32_t WgN, uint32_t SgN, uint32_t SgK, uint32_t XMXM, typename AccType, typename CType>
inline void dispatch_gemm_with_scale_mode(int iter, int n_sets, bool enable_validation) {
    if (g_external_scale_a_calc) {
        using Test = int2_dequant_base<GKS, WgM, SgM, WgN, SgN, SgK, XMXM, AccType, CType, true>;
        if (g_enable_bias && g_enable_silu) {
            int2_dequantize_gemm_run<Test, true, true>(iter, n_sets, enable_validation);
        } else if (g_enable_bias) {
            int2_dequantize_gemm_run<Test, true, false>(iter, n_sets, enable_validation);
        } else if (g_enable_silu) {
            int2_dequantize_gemm_run<Test, false, true>(iter, n_sets, enable_validation);
        } else {
            int2_dequantize_gemm_run<Test, false, false>(iter, n_sets, enable_validation);
        }
    } else {
        using Test = int2_dequant_base<GKS, WgM, SgM, WgN, SgN, SgK, XMXM, AccType, CType, false>;
        if (g_enable_bias && g_enable_silu) {
            int2_dequantize_gemm_run<Test, true, true>(iter, n_sets, enable_validation);
        } else if (g_enable_bias) {
            int2_dequantize_gemm_run<Test, true, false>(iter, n_sets, enable_validation);
        } else if (g_enable_silu) {
            int2_dequantize_gemm_run<Test, false, true>(iter, n_sets, enable_validation);
        } else {
            int2_dequantize_gemm_run<Test, false, false>(iter, n_sets, enable_validation);
        }
    }
}

// Backward compatible dispatch function - inline template to avoid multiple definitions
template <typename Test>
inline void dispatch_gemm_with_postops(int iter, int n_sets, bool enable_validation) {
    if (g_enable_bias && g_enable_silu) {
        int2_dequantize_gemm_run<Test, true, true>(iter, n_sets, enable_validation);
    } else if (g_enable_bias) {
        int2_dequantize_gemm_run<Test, true, false>(iter, n_sets, enable_validation);
    } else if (g_enable_silu) {
        int2_dequantize_gemm_run<Test, false, true>(iter, n_sets, enable_validation);
    } else {
        int2_dequantize_gemm_run<Test, false, false>(iter, n_sets, enable_validation);
    }
}

// Variant struct
struct Variant {
    uint32_t wg_m, sg_m, wg_n, sg_n, sg_k, gks;
    bool is_gemv;
    std::function<void()> fn;
};

// Wrapper that returns a callable which runs the compiled Test instantiation
// Uses dispatch_gemm_with_scale_mode to honor the g_external_scale_a_calc setting
template <uint32_t GKS, uint32_t WgM, uint32_t SgM, uint32_t WgN, uint32_t SgN, uint32_t SgK, uint32_t XMXM, typename AccType, typename CType>
std::function<void()> run_wrapper() {
    return []() {
        dispatch_gemm_with_scale_mode<void, GKS, WgM, SgM, WgN, SgN, SgK, XMXM, AccType, CType>(g_num_iters, N_SETS, g_enable_validation);
    };
}

// Precompiled variant configuration constants (constexpr for template instantiation)
constexpr uint32_t PRECOMP_GKS = 1u;

// Explicit list of (wg_m, sg_m, wg_n, sg_n, sg_k) tuples to precompile.
// Covers the 14 unique tile shapes the user requested for this slim build.
// (The Cartesian-product PRE_GEMM_WG_M / PRE_GEMM_WG_N_PAIRS / PRE_GEMM_SG_K
//  scheme was replaced because the requested tuples are not a Cartesian product.)
struct gemm_tuple_t { uint32_t wg_m, sg_m, wg_n, sg_n, sg_k; };

constexpr std::array<gemm_tuple_t, 7> PRE_GEMM_TUPLES = {{
    // (wg_m, sg_m, wg_n, sg_n, sg_k)  -- all with sg_m=8
    {  64u, 8u, 128u, 128u,  32u },
    {  32u, 8u, 256u, 128u,  64u },
    { 256u, 8u, 160u, 160u,  32u },
    {  32u, 8u, 160u, 160u,  32u },
    {  64u, 8u, 160u, 160u,  32u },
    {  64u, 8u, 256u, 128u, 128u },
    {  64u, 8u, 256u, 128u,  64u },
}};

// Precompiled GEMV variants: Cartesian product of wg_n in {64, 128, 256},
// sg_n in {16, 32}, and sg_k in {32, 64, 128}, all with wg_m=1, sg_m=1.
// (mma_xmx_m is forced to 1 for the GEMV path in precompiled_gemm.cpp.)
constexpr std::array<gemm_tuple_t, 18> PRE_GEMV_TUPLES = {{
    // wg_n=64
    { 1u, 1u,  64u, 16u,  32u },
    { 1u, 1u,  64u, 16u,  64u },
    { 1u, 1u,  64u, 16u, 128u },
    { 1u, 1u,  64u, 32u,  32u },
    { 1u, 1u,  64u, 32u,  64u },
    { 1u, 1u,  64u, 32u, 128u },
    // wg_n=128
    { 1u, 1u, 128u, 16u,  32u },
    { 1u, 1u, 128u, 16u,  64u },
    { 1u, 1u, 128u, 16u, 128u },
    { 1u, 1u, 128u, 32u,  32u },
    { 1u, 1u, 128u, 32u,  64u },
    { 1u, 1u, 128u, 32u, 128u },
    // wg_n=256
    { 1u, 1u, 256u, 16u,  32u },
    { 1u, 1u, 256u, 16u,  64u },
    { 1u, 1u, 256u, 16u, 128u },
    { 1u, 1u, 256u, 32u,  32u },
    { 1u, 1u, 256u, 32u,  64u },
    { 1u, 1u, 256u, 32u, 128u },
}};

// Forward declaration for get_precompiled_variants() function (defined in variant_registry.cpp)
std::vector<Variant> get_precompiled_variants();
