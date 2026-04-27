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

// GEMM variants compilation unit 4
#include "variant_common.hpp"

#ifdef MINIMAL_BUILD
void build_gemm_variants_4(std::vector<Variant>&) {}
#else
void build_gemm_variants_4(std::vector<Variant>& v) {
    // WG_M[1], WG_N[2], SG_K[0..4]
    constexpr uint32_t wg_m = PRE_GEMM_WG_M[1];
    constexpr uint32_t sg_m = PRE_GEMM_SG_M;
    constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[2].first;
    constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[2].second;
    
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[0], PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[0], sg_m, int32_t, bf16>()});
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[1], PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[1], sg_m, int32_t, bf16>()});
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[2], PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[2], sg_m, int32_t, bf16>()});
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[3], PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[3], sg_m, int32_t, bf16>()});
    v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[4], PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, PRE_GEMM_SG_K[4], sg_m, int32_t, bf16>()});
}
#endif // MINIMAL_BUILD
