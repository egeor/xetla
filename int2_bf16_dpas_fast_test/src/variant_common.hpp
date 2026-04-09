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
template <uint32_t GKSlicing, uint32_t WgM = 64, uint32_t SgM = 64, uint32_t WgN = 128, uint32_t SgN = 16, uint32_t SgK = 32, uint32_t XMX_M = SgM, typename AccType = int32_t, typename CType = bf16, bool UseExternalScaleA = false>
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
    
    using data_type_a = bf16;
    using data_type_b = int2x16;
    using data_type_c = CType;
    using data_type_acc = AccType;
};

// Dispatch function with external_scale_a_calc support - inline template to avoid multiple definitions
template <typename TestBase, uint32_t GKS, uint32_t WgM, uint32_t SgM, uint32_t WgN, uint32_t SgN, uint32_t SgK, uint32_t XMXM, typename AccType, typename CType>
inline void dispatch_gemm_with_scale_mode(int iter, int n_sets, bool enable_validation) {
    if (g_external_scale_a_calc == 1) {
        // External scale A calculation (separate kernel)
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
        // Internal scale A calculation (SLM within GEMM)
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

// Only precompiled variants from experimental configurations
// GEMM: wg_m ∈ {64, 128}, sg_m=8, sg_k=32
// wg_n/sg_n: (256,128), (128,128), (160,160)
constexpr std::array<uint32_t,5> PRE_GEMM_WG_M = {16u, 32u, 64u, 128u, 256u};
constexpr std::array<std::pair<uint32_t, uint32_t>, 3> PRE_GEMM_WG_N_PAIRS = {
    std::pair<uint32_t, uint32_t> {256u, 128u},
    std::pair<uint32_t, uint32_t> {128u, 128u},
    std::pair<uint32_t, uint32_t> {160u, 160u}
};
constexpr std::array<uint32_t, 5> PRE_GEMM_SG_K = {32u, 64u, 96u, 128u, 160u};

// GEMV: wg_m=1, sg_m=1
// wg_n/sg_n pairs: 10 pairs total for comprehensive coverage
// sg_k: 128, 160, 256, 32
constexpr std::array<std::pair<uint32_t, uint32_t>, 13> PRE_GEMV_WG_N_PAIRS = {
    std::pair<uint32_t, uint32_t> {16u, 16u},
    std::pair<uint32_t, uint32_t> {32u, 32u},
    std::pair<uint32_t, uint32_t> {32u, 16u},
    std::pair<uint32_t, uint32_t> {64u, 64u},
    std::pair<uint32_t, uint32_t> {64u, 32u},
    std::pair<uint32_t, uint32_t> {64u, 16u},
    std::pair<uint32_t, uint32_t> {80u, 80u},
    std::pair<uint32_t, uint32_t> {80u, 32u},
    std::pair<uint32_t, uint32_t> {80u, 16u},
    std::pair<uint32_t, uint32_t> {128u, 128u},
    std::pair<uint32_t, uint32_t> {128u, 64u},
    std::pair<uint32_t, uint32_t> {128u, 32u},
    std::pair<uint32_t, uint32_t> {128u, 16u}
};
constexpr std::array<uint32_t, 4> PRE_GEMV_SG_K = {32u, 128u, 160u, 256u};

constexpr uint32_t PRE_GEMM_SG_M = 8u;
constexpr uint32_t PRE_GEMV_WG_M = 1u;
constexpr uint32_t PRE_GEMV_SG_M = 1u;

// Forward declaration for get_precompiled_variants() function (defined in variant_registry.cpp)
std::vector<Variant> get_precompiled_variants();
