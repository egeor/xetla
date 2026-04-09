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

// Forward declaration of Variant struct
struct Variant {
    uint32_t wg_m, sg_m, wg_n, sg_n, sg_k, gks;
    bool is_gemv;
    std::function<void(int, int, bool)> run_func;
};

// Function to build GEMM variants (implemented in precompiled_gemm.cpp)
void build_gemm_variants(std::vector<Variant>& variants);

// Function to build GEMV variants (implemented in precompiled_gemv.cpp)
void build_gemv_variants(std::vector<Variant>& variants);

// Function to get all precompiled variants (implemented in variant_registry.cpp)
std::vector<Variant> get_precompiled_variants();
