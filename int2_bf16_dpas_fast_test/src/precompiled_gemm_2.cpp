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

// GEMM variants compilation unit 2
#include "variant_common.hpp"

void build_gemm_variants_2(std::vector<Variant>& v) {
    // WG_M[0], WG_N[2], SG_K[0..4]
    constexpr uint32_t wg_m = PRE_GEMM_WG_M[0];
    constexpr uint32_t sg_m = PRE_GEMM_SG_M;
    
    // Variant 1: WG_M[0], WG_N[2], SG_K[0]
    {
        constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[2].first;
        constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[2].second;
        constexpr uint32_t sg_k = PRE_GEMM_SG_K[0];
        v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, sg_m, int32_t, bf16>()});
    }
    
    // Variant 2: WG_M[0], WG_N[2], SG_K[1]
    {
        constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[2].first;
        constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[2].second;
        constexpr uint32_t sg_k = PRE_GEMM_SG_K[1];
        v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, sg_m, int32_t, bf16>()});
    }
    
    // Variant 3: WG_M[0], WG_N[2], SG_K[2]
    {
        constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[2].first;
        constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[2].second;
        constexpr uint32_t sg_k = PRE_GEMM_SG_K[2];
        v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, sg_m, int32_t, bf16>()});
    }
    
    // Variant 4: WG_M[0], WG_N[2], SG_K[3]
    {
        constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[2].first;
        constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[2].second;
        constexpr uint32_t sg_k = PRE_GEMM_SG_K[3];
        v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, sg_m, int32_t, bf16>()});
    }
    
    // Variant 5: WG_M[0], WG_N[2], SG_K[4]
    {
        constexpr uint32_t wg_n = PRE_GEMM_WG_N_PAIRS[2].first;
        constexpr uint32_t sg_n = PRE_GEMM_WG_N_PAIRS[2].second;
        constexpr uint32_t sg_k = PRE_GEMM_SG_K[4];
        v.push_back(Variant{wg_m, sg_m, wg_n, sg_n, sg_k, PRECOMP_GKS, false, run_wrapper<PRECOMP_GKS, wg_m, sg_m, wg_n, sg_n, sg_k, sg_m, int32_t, bf16>()});
    }
}
