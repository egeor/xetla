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

// This compilation unit builds the complete registry of precompiled variants
// It depends on precompiled_gemm.cpp and precompiled_gemv.cpp

#include "variant_common.hpp"

// Forward declarations from separate compilation units
void build_gemm_variants(std::vector<Variant>& v);
void build_gemm_variants_1(std::vector<Variant>& v);
void build_gemm_variants_2(std::vector<Variant>& v);
void build_gemm_variants_3(std::vector<Variant>& v);
void build_gemm_variants_4(std::vector<Variant>& v);
void build_gemm_variants_5(std::vector<Variant>& v);
void build_gemm_variants_6(std::vector<Variant>& v);
void build_gemm_variants_7(std::vector<Variant>& v);
void build_gemm_variants_8(std::vector<Variant>& v);
void build_gemm_variants_9(std::vector<Variant>& v);
void build_gemm_variants_10(std::vector<Variant>& v);
void build_gemm_variants_11(std::vector<Variant>& v);
void build_gemm_variants_12(std::vector<Variant>& v);
void build_gemm_variants_13(std::vector<Variant>& v);
void build_gemv_variants(std::vector<Variant>& v);
void build_gemv_variants_1(std::vector<Variant>& v);

// Build the complete vector of precompiled variants
static std::vector<Variant> build_precompiled_variants() {
    std::vector<Variant> v;
    build_gemm_variants(v);
    build_gemm_variants_1(v);
    build_gemm_variants_2(v);
    build_gemm_variants_3(v);
    build_gemm_variants_4(v);
    build_gemm_variants_5(v);
    build_gemm_variants_6(v);
    build_gemm_variants_7(v);
    build_gemm_variants_8(v);
    build_gemm_variants_9(v);
    build_gemm_variants_10(v);
    build_gemm_variants_11(v);
    build_gemm_variants_12(v);
    build_gemm_variants_13(v);
    build_gemv_variants(v);
    build_gemv_variants_1(v);
    return v;
}

// Expose the precompiled variant list (constructed at program startup)
std::vector<Variant> get_precompiled_variants() {
    static const std::vector<Variant> v = build_precompiled_variants();
    return v;
}
