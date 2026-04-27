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

// This compilation unit contains all GEMV variant instantiations
// Changes to main.cpp won't trigger recompilation of this expensive file

#include "variant_common.hpp"

// Helper to add GEMV variants
template <size_t IN, size_t IK>
void add_gemv_variant(std::vector<Variant> &v) {
    constexpr uint32_t wg_m = PRE_GEMV_WG_M;
    constexpr uint32_t sg_m = PRE_GEMV_SG_M;
    constexpr uint32_t wg_n = PRE_GEMV_WG_N_PAIRS[IN].first;
    constexpr uint32_t sg_n = PRE_GEMV_WG_N_PAIRS[IN].second;
    constexpr uint32_t sg_k = PRE_GEMV_SG_K[IK];
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, true, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, 1, int32_t, fp16>()});
}

// Recursive compile-time unrolling over PRE_GEMV_WG_N_PAIRS and PRE_GEMV_SG_K
template <size_t IN, size_t IK>
struct UnrollGemvInner {
    static void run(std::vector<Variant> &v) {
        add_gemv_variant<IN, IK>(v);
        if constexpr (IK + 1 < PRE_GEMV_SG_K.size()) UnrollGemvInner<IN, IK + 1>::run(v);
    }
};

template <size_t IN>
struct UnrollGemvOuter {
    static void run(std::vector<Variant> &v) {
        UnrollGemvInner<IN, 0>::run(v);
        if constexpr (IN + 1 < PRE_GEMV_WG_N_PAIRS.size()) UnrollGemvOuter<IN + 1>::run(v);
    }
};

// Build GEMV variants
void build_gemv_variants(std::vector<Variant>& v) {
    if constexpr (PRE_GEMV_WG_N_PAIRS.size() > 0 && PRE_GEMV_SG_K.size() > 0) {
        UnrollGemvOuter<0>::run(v);
    }
}
