/*******************************************************************************
* Copyright (c) 2022-2023 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
*******************************************************************************/

// Explicit-list registration of all 14 precompiled tile tuples (7 GEMM + 7 GEMV).
// Each entry calls run_wrapper<GKS, wg_m, sg_m, wg_n, sg_n, sg_k, mma_xmx_m, AccType, CType>().
// For GEMM: mma_xmx_m == sg_m. For GEMV: mma_xmx_m == 1 (sg_m).

#include "variant_common.hpp"

template <size_t I>
static void add_gemm_tuple(std::vector<Variant> &v) {
    constexpr auto t = PRE_GEMM_TUPLES[I];
    v.push_back(Variant{
        t.wg_m, t.sg_m, t.wg_n, t.sg_n, t.sg_k, PRECOMP_GKS, /*is_gemv*/false,
        run_wrapper<PRECOMP_GKS, t.wg_m, t.sg_m, t.wg_n, t.sg_n, t.sg_k, t.sg_m, int32_t, fp16>()});
}

template <size_t I>
static void add_gemv_tuple(std::vector<Variant> &v) {
    constexpr auto t = PRE_GEMV_TUPLES[I];
    v.push_back(Variant{
        t.wg_m, t.sg_m, t.wg_n, t.sg_n, t.sg_k, PRECOMP_GKS, /*is_gemv*/true,
        run_wrapper<PRECOMP_GKS, t.wg_m, t.sg_m, t.wg_n, t.sg_n, t.sg_k, /*mma_xmx_m*/1u, int32_t, fp16>()});
}

template <size_t I>
struct UnrollGemm {
    static void run(std::vector<Variant> &v) {
        add_gemm_tuple<I>(v);
        if constexpr (I + 1 < PRE_GEMM_TUPLES.size()) UnrollGemm<I + 1>::run(v);
    }
};

template <size_t I>
struct UnrollGemv {
    static void run(std::vector<Variant> &v) {
        add_gemv_tuple<I>(v);
        if constexpr (I + 1 < PRE_GEMV_TUPLES.size()) UnrollGemv<I + 1>::run(v);
    }
};

void build_gemm_variants(std::vector<Variant>& v) {
    if constexpr (PRE_GEMM_TUPLES.size() > 0) UnrollGemm<0>::run(v);
    if constexpr (PRE_GEMV_TUPLES.size() > 0) UnrollGemv<0>::run(v);
}
