// Explicit template instantiations for int2_dequantize_gemm_run
// This file provides the actual function implementations that are referenced
// by the precompiled variant registry

#include "variant_common.hpp"

// Forward declare the template function from main.cpp
template <class Test, bool EnableBias, bool EnableSiLU>
void int2_dequantize_gemm_run(int iter, int n_sets, bool enable_validation);

// Macro to instantiate all 4 post-op combinations for a given Test type
// Use variadic macro to handle commas in template arguments
#define INSTANTIATE_ALL_POSTOPS(...) \
    template void int2_dequantize_gemm_run<__VA_ARGS__, false, false>(int, int, bool); \
    template void int2_dequantize_gemm_run<__VA_ARGS__, true, false>(int, int, bool); \
    template void int2_dequantize_gemm_run<__VA_ARGS__, false, true>(int, int, bool); \
    template void int2_dequantize_gemm_run<__VA_ARGS__, true, true>(int, int, bool);

// GEMM instantiations (6 total: 2 wg_m × 3 (wg_n, sg_n) pairs)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 64u, 8u, 256u, 128u, 32u, 8u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 64u, 8u, 128u, 128u, 32u, 8u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 64u, 8u, 160u, 160u, 32u, 8u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 128u, 8u, 256u, 128u, 32u, 8u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 128u, 8u, 128u, 128u, 32u, 8u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 128u, 8u, 160u, 160u, 32u, 8u, int32_t, fp16>)

// GEMV instantiations (20 total: 5 (wg_n, sg_n) pairs × 4 sg_k values)
// (32, 32) with sg_k variants
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 32u, 32u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 32u, 128u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 32u, 160u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 32u, 256u, 1u, int32_t, fp16>)

// (32, 16) with sg_k variants
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 16u, 32u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 16u, 128u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 16u, 160u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 32u, 16u, 256u, 1u, int32_t, fp16>)

// (64, 64) with sg_k variants
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 64u, 32u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 64u, 128u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 64u, 160u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 64u, 256u, 1u, int32_t, fp16>)

// (64, 32) with sg_k variants
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 32u, 32u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 32u, 128u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 32u, 160u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 32u, 256u, 1u, int32_t, fp16>)

// (64, 16) with sg_k variants
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 16u, 32u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 16u, 128u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 16u, 160u, 1u, int32_t, fp16>)
INSTANTIATE_ALL_POSTOPS(int2_dequant_base<1u, 1u, 1u, 64u, 16u, 256u, 1u, int32_t, fp16>)
