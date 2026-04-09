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

// This compilation unit contains all GEMM variant instantiations
// Changes to main.cpp won't trigger recompilation of this expensive file

#include "variant_common.hpp"

// Helper to add GEMM variants
template <size_t IM, size_t IN, size_t IK>
void add_gemm_variant(std::vector<Variant> &v) {
    constexpr uint32_t wg_m = PRE_GEMM_WG_M[IM];
    constexpr uint32_t sg_m = PRE_GEMM_SG_M;
    constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[IN].first;
    constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[IN].second;
    constexpr uint32_t sg_k = PRE_GEMM_SG_K[IK];
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, sg_m, int32_t, bf16>()});
}

// Recursive compile-time unrolling over PRE_GEMM_SG_K (innermost loop)
template <size_t IM, size_t IN, size_t IK>
struct UnrollGemmInnermost {
    static void run(std::vector<Variant> &v) {
        add_gemm_variant<IM, IN, IK>(v);
        if constexpr (IK + 1 < PRE_GEMM_SG_K.size()) UnrollGemmInnermost<IM, IN, IK + 1>::run(v);
    }
};

// Recursive compile-time unrolling over PRE_GEMM_WG_N_PAIRS (middle loop)
template <size_t IM, size_t IN>
struct UnrollGemmInner {
    static void run(std::vector<Variant> &v) {
        UnrollGemmInnermost<IM, IN, 0>::run(v);
        if constexpr (IN + 1 < PRE_GEMM_WG_N_PAIRS.size()) UnrollGemmInner<IM, IN + 1>::run(v);
    }
};

// Recursive compile-time unrolling over PRE_GEMM_WG_M (outermost loop)
template <size_t IM>
struct UnrollGemmOuter {
    static void run(std::vector<Variant> &v) {
        UnrollGemmInner<IM, 0>::run(v);
        if constexpr (IM + 1 < PRE_GEMM_WG_M.size()) UnrollGemmOuter<IM + 1>::run(v);
    }
};

// Build GEMM variants
void build_gemm_variants(std::vector<Variant>& v) {
    if constexpr (PRE_GEMM_WG_M.size() > 0 && PRE_GEMM_WG_N_PAIRS.size() > 0 && PRE_GEMM_SG_K.size() > 0) {
        UnrollGemmOuter<0>::run(v);
    }
}
