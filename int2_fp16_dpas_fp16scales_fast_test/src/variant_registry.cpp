/*******************************************************************************
* Copyright (c) 2022-2023 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*******************************************************************************/

// Single-variant registry for the int2 fp16 DPAS test with FP16 scales.
// Only one precompiled GEMM variant is built (the requested config); all the
// fan-out aggregator/split-unit machinery from the original test was removed
// to keep compilation time minimal.

#include "variant_common.hpp"

void build_gemm_variants(std::vector<Variant>& v);

static std::vector<Variant> build_precompiled_variants() {
    std::vector<Variant> v;
    build_gemm_variants(v);
    return v;
}

std::vector<Variant> get_precompiled_variants() {
    static const std::vector<Variant> v = build_precompiled_variants();
    return v;
}
