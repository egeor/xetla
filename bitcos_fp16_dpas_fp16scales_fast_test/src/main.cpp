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

// Minimal driver for the int1 weight-only quantized GEMM with fp16
// activations and per-K-group fp16 ScaleB:
//
//   C[m,n] = (sum over k of A[m,k] * (codeval(B[k,n]) * ScaleB[k/gs, n])) cast fp16.
//
// Layout summary:
//   A      : fp16, row-major, [M, K]
//   B      : int1x32, K-packed, [K/32, N] (each uint32_t holds 32 K-rows for one N-col)
//   ScaleB : fp16, row-major, [K/gs, N]
//   C      : fp16, row-major, [M, N]
//
// int1 codes:
//     code 0 -> +1
//     code 1 -> -1
// Upconvert is a single XOR: result_bits = scale_bits ^ (code << 15)
// (since scale is positive fp16, flipping bit 15 negates).

#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <random>
#include <vector>

#include <omp.h>

#include "utils/buff_compare.hpp"
#include "utils/profiling.hpp"
#include "xetla.hpp"

using namespace gpu::xetla;
using namespace sycl;

#ifndef DEVICE_MEM_ALIGNMENT
#define DEVICE_MEM_ALIGNMENT 256
#endif

// ---------------------------------------------------------------------------
// Compile-time configuration

// Scale group size in K-elements. Must divide K and be a multiple of 16.
static constexpr int kScaleGS = 128;

// Default problem and tile sizes (override via CLI in main()).
// Default tile config (single-row workgroup tile, ideal for small-M / GEMV):
//   wg_m=1, sg_m=1, wg_n=128, sg_n=16, sg_k=128
// XMX repeat_count is forwarded as mma_xmx_m == sg_m so it works with sg_m=1.
struct RunConfig {
    int matrix_m = 32;
    int matrix_n = 4096;
    int matrix_k = 4096;
    int iters    = 5;
    bool validate = true;
    double zero_frac = 0.47;
    bool pos_only = false; // diagnostic: no negative weights, sign plane all 0
    bool neg_only = false; // diagnostic: no positive weights, sign plane all 1
    bool sign_k_parity = false; // diagnostic: every sign word is 0xAAAAAAAA
    bool sign_n_parity = false; // diagnostic: sign constant down k, varies by column
    bool sign_kp_parity = false; // diagnostic: sign word alternates per packed k row
    // Cache-defeat: allocate multiple distinct device-side buffer sets and
    // rotate through them across iterations so the working set exceeds GPU
    // cache. If num_sets == 0 it is auto-sized from min_footprint_gb.
    int    num_sets         = 0;
    double min_footprint_gb = 2.0;
    // If true, each device buffer set gets independently randomized
    // A/B/ScaleB inputs (and is validated against its own gold reference).
    // Default false: one host init is broadcast to all sets.
    bool distinct_sets = false;
    // Manual tile override (sweep mode). When override_wg_n > 0, run_gemm()
    // dispatches to the (wg_n, KS, LS) instantiation matching the override
    // values, bypassing the auto-tier logic. wg_n in {32,64,128},
    // KS in {1,2,4}, LS in {1,2,4}.
    int override_wg_n = 0;
    int override_ks   = 0;
    int override_ls   = 0;
    int override_sg_n = 16;
    int override_sg_k = 128;
};

// SYCL kernel name tags (avoid mangled-name collisions; one per shape variant).
template <int WGM, int WGN, int SGM, int SGN, int SGK, int KS, int LS = 1,
        bool kUnaligned = false>
class int1_fp16_upcvt_kernel;

// ---------------------------------------------------------------------------
// Helpers

double get_time_seconds() {
    auto now = std::chrono::high_resolution_clock::now();
    return std::chrono::duration<double>(now.time_since_epoch()).count();
}

uint32_t random_uint32() {
    static thread_local std::mt19937 gen(std::random_device{}());
    static thread_local std::uniform_int_distribution<uint32_t> dis(0, UINT32_MAX);
    return dis(gen);
}

float random_float(float lo, float hi) {
    static thread_local std::mt19937 gen(std::random_device{}());
    std::uniform_real_distribution<float> dist(lo, hi);
    return dist(gen);
}

// Map int1 code (0 or 1) to its signed value: 0 -> +1, 1 -> -1.
static inline int int1_code_to_value(uint32_t code) {
    return (code & 1u) ? -1 : +1;
}

#include "bitcos_format.hpp"

#include <cstring>
#include <random>
#include <vector>

template <typename DTypeC>
static void compute_gold(const fp16 *A, const int8_t *codes,
        const fp16 *ScaleB, DTypeC *gold_C, int M, int K, int N,
        int scale_gs, int ldb, int ld_scale) {
    const int ks_groups = K / scale_gs;
#pragma omp parallel for collapse(2)
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            float accum = 0.0f;
            for (int gk = 0; gk < ks_groups; ++gk) {
                float scale
                        = static_cast<float>(ScaleB[gk * ld_scale + j]);
                float partial = 0.0f;
                for (int p = 0; p < scale_gs; ++p) {
                    int ik = gk * scale_gs + p;
                    int bv = static_cast<int>(
                            codes[static_cast<size_t>(ik) * N + j]);
                    partial += static_cast<float>(A[i * K + ik])
                            * static_cast<float>(bv);
                }
                accum += partial * scale;
            }
            gold_C[static_cast<size_t>(i) * N + j]
                    = static_cast<DTypeC>(accum);
        }
    }
}

template <typename DTypeC>
static bool compare_against_gold(const DTypeC *C, const DTypeC *gold_C,
        int M, int N, const std::string &label) {
    buff_cmp::buff_vals<DTypeC> data(const_cast<DTypeC *>(C), M, N, N);
    buff_cmp::buff_vals<DTypeC, DTypeC> other(
            const_cast<DTypeC *>(gold_C), M, N, N);
    return buff_cmp::xetla_buff_cmp(data, other, label,
            /*diff_elems_tol*/ 0.001, /*ulp_tol*/ 64, /*abs_tol*/ 8.0);
}

// ---------------------------------------------------------------------------
// Run one GEMM with compile-time tile sizes.

template <int WGM, int WGN, int SGM, int SGN, int SGK, int KS = 1, int LS = 1,
        bool kUnaligned = false>
void run_gemm_impl_inner(const RunConfig &cfg) {
    using data_type_a   = fp16;
    using data_type_b   = int1x32;
    using data_type_c   = fp16;
    using data_type_acc = float;
    using data_type_scale = fp16;

    constexpr int wg_tile_m = WGM;
    constexpr int wg_tile_n = WGN;
    constexpr int sg_tile_m = SGM;
    constexpr int sg_tile_n = SGN;
    constexpr int sg_tile_k = SGK;
    constexpr uint32_t prefetch_distance       = 0;
    constexpr uint32_t periodic_sync_interval  = 0;
    constexpr uint32_t global_kslicing         = KS;
    constexpr uint32_t local_kslicing          = LS;

    const int M  = cfg.matrix_m;
    const int N  = cfg.matrix_n;
    const int K  = cfg.matrix_k;
    const int gs = kScaleGS;

    if (K % gs != 0) {
        std::cerr << "K (" << K << ") must be divisible by scale_gs (" << gs
                  << ")\n";
        std::exit(1);
    }
    if (K % 32 != 0) {
        std::cerr << "K (" << K << ") must be divisible by 32 (int1x32)\n";
        std::exit(1);
    }

    sycl::property_list properties {
            sycl::property::queue::enable_profiling()};
    sycl::queue queue(properties);
    auto context = queue.get_info<info::queue::context>();
    auto device  = queue.get_info<info::queue::device>();
    std::cout << "Device: "
              << device.get_info<info::device::name>() << "\n";
    std::cout << "Problem: M=" << M << " N=" << N << " K=" << K
              << " scale_gs=" << gs << "\n";

    // ----- XeTLA types -----
    static constexpr gpu_arch arch_tag = gpu_arch::Xe;
    using tile_shape = gpu::xetla::group::tile_shape_t<wg_tile_n, wg_tile_m,
            sg_tile_n, sg_tile_m>;

    using mem_desc_a_t = gpu::xetla::mem_desc_t<data_type_a, mem_layout::row_major,
            mem_space::global>;
    using mem_desc_b_t = gpu::xetla::mem_desc_t<data_type_b, mem_layout::row_major,
            mem_space::global>;
    using mem_desc_c_t = gpu::xetla::mem_desc_t<data_type_c, mem_layout::row_major,
            mem_space::global>;

    // For the upcvt path, dtype_mma_a == dtype_mma_b == fp16, accumulator fp32.
    using compute_attr = gpu::xetla::group::compute_attr_t<data_type_a, data_type_a,
            data_type_acc>;
    using perf_tuning_knob = gpu::xetla::group::perf_tuning_knob_t<sg_tile_k,
            prefetch_distance, periodic_sync_interval>;
    using compute_policy
            = gpu::xetla::group::compute_policy_bitcos_fp16_upcvt_xmx<compute_attr,
                    perf_tuning_knob, data_type_scale, kScaleGS,
                    /*mma_xmx_m=*/SGM, arch_tag, /*use_unaligned_n=*/kUnaligned>;
    using gemm_t = gpu::xetla::group::gemm_t<compute_policy, tile_shape,
            mem_desc_a_t, mem_desc_b_t>;

    using epilogue_policy_t = std::conditional_t<kUnaligned,
            gpu::xetla::group::epilogue_policy_unaligned<arch_tag>,
            gpu::xetla::group::epilogue_policy_default<arch_tag>>;
    // For the unaligned path we MUST force the epilogue's mem_desc_c
    // alignment to 1 element. Otherwise mem_payload_t<unaligned_2d>
    // picks mem_dtype = uint64_t (4 fp16/lane) and the OOB predicate
    // guards at uint64 granularity, writing up to 3 fp16s past N on
    // any N not multiple of 4 -- silent for M=1 (USM slack absorbs
    // it) but corrupts row+1 for M>1. See tests/integration/gemm/
    // unaligned_bf16/kernel_func.hpp for the canonical pattern.
    using mem_desc_c_epilogue_t = std::conditional_t<kUnaligned,
            gpu::xetla::mem_desc_t<data_type_c, mem_layout::row_major,
                    mem_space::global, /*alignment=*/1>,
            mem_desc_c_t>;
    using epilogue_t = gpu::xetla::group::epilogue_t<epilogue_policy_t,
            tile_shape, mem_desc_c_epilogue_t>;
    using group_swizzle = gpu::xetla::kernel::group_swizzle_default<arch_tag>;
    using gemm_op_t = gpu::xetla::kernel::gemm_universal_t<
            gpu::xetla::kernel::dispatch_policy_bitcos_fp16_upcvt_kslicing<
                    group_swizzle, global_kslicing, local_kslicing>,
            gemm_t, epilogue_t>;

    // ----- Sizes -----
    // Zero driver-side LD padding: matB_ld == matC_ld == scale_ld ==
    // matrix_n. The aligned-N (N % 4 == 0) compile path uses block_2d
    // on matB/matC and gets HW pitch alignment for free. The
    // arbitrary-N path uses block_1d on matB (per-packed-row loads),
    // unaligned_2d on matC, and unaligned_2d on scale -- all three
    // accept any pitch with zero padding.
    const uint32_t ldb_padded = static_cast<uint32_t>(N);
    const uint32_t ldc_padded = static_cast<uint32_t>(N);
    const uint32_t lds_padded = static_cast<uint32_t>(N);
    const size_t size_a = static_cast<size_t>(M) * K;

    // BITCOS weights: draw ternary codes at the requested zero fraction and
    // pack once on the host. The sign plane is data dependent, so the device
    // allocation is sized from the packed result rather than from (K, N).
    std::vector<int8_t> codes(static_cast<size_t>(K) * N);
    {
        std::mt19937 rng(20260817u);
        std::uniform_real_distribution<double> u(0.0, 1.0);
        for (size_t i = 0; i < codes.size(); ++i) {
            const size_t k = i / static_cast<size_t>(N);
            codes[i] = cfg.sign_kp_parity
                    ? (((k / 32) % 2) ? int8_t(-1) : int8_t(1))
                    : cfg.sign_n_parity
                    ? (((i % static_cast<size_t>(N)) % 2) ? int8_t(-1) : int8_t(1))
                    : cfg.sign_k_parity
                    ? ((k % 2) ? int8_t(-1) : int8_t(1))
                    : cfg.neg_only ? ((u(rng) < cfg.zero_frac) ? int8_t(0) : int8_t(-1))
                             : (u(rng) < cfg.zero_frac)
                    ? int8_t(0)
                    : ((!cfg.pos_only && u(rng) < 0.5) ? int8_t(-1)
                                                       : int8_t(1));
        }
    }
    std::vector<uint32_t> bitcos_buf;
    const auto bitcos_sizes
            = bitcos::pack(codes.data(), K, N, bitcos_buf);
    const size_t size_b_payload = bitcos_buf.size();
    // the 64-bit sign window always gathers a high word, so the last run
    // needs one readable word past its end
    bitcos_buf.push_back(0u);
    const size_t size_b_words = bitcos_buf.size();
    const size_t bitcos_offsets_off = bitcos::offsets_word_base(K, N);
    const size_t bitcos_signs_off = bitcos::signs_word_base(K, N);
    std::cout << "BITCOS: z=" << cfg.zero_frac << "  bits/weight="
              << bitcos::bits_per_weight(bitcos_sizes, K, N)
              << "  (int2 reference 2.000)\n";
    // Device matC uses padded LD; host C/gold stay at logical M*N.
    const size_t size_c        = static_cast<size_t>(M) * ldc_padded;
    const size_t size_c_host   = static_cast<size_t>(M) * N;
    const int    ks_groups   = K / gs;
    const size_t size_scale_b = static_cast<size_t>(ks_groups) * lds_padded;
    const size_t size_acc = gemm_op_t::get_acc_buf_size(M, N);
    const size_t size_cnt = gemm_op_t::get_cnt_buf_size(M, N);

    // ----- Decide how many distinct buffer sets to allocate -----
    const double bytes_a_d      = static_cast<double>(size_a)
            * sizeof(data_type_a);
    const double bytes_b_d      = static_cast<double>(size_b_payload)
            * sizeof(data_type_b);
    const double bytes_c_d      = static_cast<double>(size_c)
            * sizeof(data_type_c);
    const double bytes_scaleb_d = static_cast<double>(size_scale_b)
            * sizeof(data_type_scale);
    const double bytes_per_set  = bytes_a_d + bytes_b_d + bytes_c_d
            + bytes_scaleb_d;
    int num_sets = cfg.num_sets;
    if (num_sets <= 0) {
        const double target_bytes = cfg.min_footprint_gb * 1e9;
        num_sets = static_cast<int>(
                std::ceil(target_bytes / bytes_per_set));
        if (num_sets < 1) num_sets = 1;
    }
    const double total_footprint_gb
            = bytes_per_set * num_sets / 1e9;
    std::cout << "Per-set bytes: "
              << bytes_per_set / (1024.0 * 1024.0) << " MiB; "
              << "using " << num_sets << " distinct set"
              << (num_sets == 1 ? "" : "s") << " -> total footprint "
              << std::fixed << std::setprecision(3)
              << total_footprint_gb << " GB\n";

    // ----- Allocate host buffers (one copy; reused across all sets) -----
    auto A_h = static_cast<data_type_a *>(
            malloc_host(size_a * sizeof(data_type_a), context));
    auto B_h = static_cast<data_type_b *>(
            malloc_host(size_b_words * sizeof(data_type_b), context));
    auto C_h = static_cast<data_type_c *>(
            malloc_host(size_c_host * sizeof(data_type_c), context));
    auto ScaleB_h = static_cast<data_type_scale *>(
            malloc_host(size_scale_b * sizeof(data_type_scale), context));

    // ----- Initialize host buffers (one shared init; possibly re-randomized
    //       per set below if cfg.distinct_sets is set) -----
    auto fill_host_inputs = [&](data_type_a *A, data_type_b *B,
                                    data_type_scale *S) {
#pragma omp parallel for
        for (size_t i = 0; i < size_a; ++i) {
            A[i] = static_cast<fp16>(random_float(-5.0f, 5.0f));
        }
        // BITCOS weights were packed above; copy the prepacked planes in.
        std::memcpy(B, bitcos_buf.data(),
                bitcos_buf.size() * sizeof(uint32_t));
        for (size_t i = 0; i < size_scale_b; ++i) {
            // Random scale in [0.75, 15.75]; positive to avoid extra sign
            // noise.
            S[i] = static_cast<fp16>(random_float(0.0f, 15.0f) + 0.75f);
        }
    };

    fill_host_inputs(A_h, B_h, ScaleB_h);

    // Per-set gold references. With distinct_sets each set gets its own
    // gold; otherwise all sets share gold[0].
    const int num_golds
            = (cfg.validate && cfg.distinct_sets) ? num_sets : 1;
    std::vector<data_type_c *> gold_C_set;
    if (cfg.validate) {
        gold_C_set.resize(num_golds);
        for (int g = 0; g < num_golds; ++g) {
            gold_C_set[g] = static_cast<data_type_c *>(malloc_host(
                    size_c_host * sizeof(data_type_c), context));
        }
        // Gold for the shared init (also serves as gold[0] for distinct_sets,
        // since we'll reuse the current host buffers for set 0 below).
        compute_gold<data_type_c>(A_h,
                codes.data(), ScaleB_h,
                gold_C_set[0], M, K, N, gs,
                static_cast<int>(ldb_padded),
                static_cast<int>(lds_padded));
    }

    // ----- Allocate `num_sets` distinct device buffer sets -----
    std::vector<data_type_a *>     A_d_set(num_sets);
    std::vector<data_type_b *>     B_d_set(num_sets);
    std::vector<data_type_c *>     C_d_set(num_sets);
    std::vector<data_type_scale *> ScaleB_d_set(num_sets);
    for (int s = 0; s < num_sets; ++s) {
        A_d_set[s] = static_cast<data_type_a *>(aligned_alloc_device(
                DEVICE_MEM_ALIGNMENT, size_a * sizeof(data_type_a),
                device, context));
        B_d_set[s] = static_cast<data_type_b *>(aligned_alloc_device(
                DEVICE_MEM_ALIGNMENT,
                size_b_words * sizeof(data_type_b), device, context));
        C_d_set[s] = static_cast<data_type_c *>(aligned_alloc_device(
                DEVICE_MEM_ALIGNMENT, size_c * sizeof(data_type_c),
                device, context));
        ScaleB_d_set[s] = static_cast<data_type_scale *>(
                aligned_alloc_device(DEVICE_MEM_ALIGNMENT,
                        size_scale_b * sizeof(data_type_scale),
                        device, context));
        if (!A_d_set[s] || !B_d_set[s] || !C_d_set[s]
                || !ScaleB_d_set[s]) {
            std::cerr << "Device alloc failed at set " << s
                      << " (footprint " << total_footprint_gb
                      << " GB).\n";
            std::exit(1);
        }
        // For set s>0 with distinct_sets, re-randomize host buffers and
        // recompute the matching gold reference. Set 0 always uses the
        // initial host init.
        if (cfg.distinct_sets && s > 0) {
            fill_host_inputs(A_h, B_h, ScaleB_h);
            if (cfg.validate) {
                compute_gold<data_type_c>(A_h,
                        codes.data(),
                        ScaleB_h, gold_C_set[s], M, K, N, gs,
                        static_cast<int>(ldb_padded),
                        static_cast<int>(lds_padded));
            }
        }
        queue.memcpy(A_d_set[s], A_h,
                size_a * sizeof(data_type_a)).wait();
        queue.memcpy(B_d_set[s], B_h,
                size_b_words * sizeof(data_type_b)).wait();
        queue.memcpy(ScaleB_d_set[s], ScaleB_h,
                size_scale_b * sizeof(data_type_scale)).wait();
        queue.memset(C_d_set[s], 0,
                size_c * sizeof(data_type_c)).wait();
    }

    // Acc/Cnt are kslicing scratch (single-set is fine: kslicing == 1).
    auto Acc_d = static_cast<data_type_acc *>(aligned_alloc_device(
            DEVICE_MEM_ALIGNMENT, size_acc * sizeof(data_type_acc), device,
            context));
    auto Cnt_d = static_cast<uint32_t *>(aligned_alloc_device(
            DEVICE_MEM_ALIGNMENT, size_cnt * sizeof(uint32_t), device,
            context));
    queue.memset(Acc_d, 0, size_acc * sizeof(data_type_acc)).wait();
    queue.memset(Cnt_d, 0, size_cnt * sizeof(uint32_t)).wait();

    // ----- Build args (set 0; per-iter args are rebuilt below) -----
    uint32_t lda = K;
    uint32_t ldb = ldb_padded;       // matB int1x32 pitch (next-even N)
    uint32_t ldc = ldc_padded;       // matC fp16   pitch (next-mul-of-4 N)
    uint32_t ld_scale_b = lds_padded; // ScaleB block_1d pitch (next-mul-of-16)

    typename gemm_op_t::arguments_t gemm_arg(M, K, N, A_d_set[0], lda,
            B_d_set[0], ldb, C_d_set[0], ldc, ScaleB_d_set[0], ld_scale_b,
            reinterpret_cast<uint32_t *>(B_d_set[0]) + bitcos_signs_off,
            reinterpret_cast<uint32_t *>(B_d_set[0]) + bitcos_offsets_off,
            Acc_d, Cnt_d);

    if (!gemm_op_t::can_implement(gemm_arg)) {
        std::cerr << "Arguments not supported by gemm_op_t::can_implement.\n";
        std::exit(1);
    }
    sycl::nd_range<3> nd_range = gemm_op_t::get_nd_range(gemm_arg);

    std::cout << "SLM size: " << gemm_op_t::get_slm_size()
              << " bytes, barriers: " << gemm_op_t::get_barrier_count()
              << "\n";

    // ----- Launch -----
    profiling_helper prof("int1_fp16_upcvt_gemm",
            2.0 * static_cast<double>(M) * N * K, "gflops");

    using kernel_name_t = int1_fp16_upcvt_kernel<WGM, WGN, SGM, SGN, SGK, KS, LS,
            kUnaligned>;

    double host_total_ms = 0.0;
    double device_total_ns = 0.0;
    int timed_iters = 0;
    // Warm-up: touch every set once (untimed) so allocation/page-fault costs
    // do not pollute the timed measurement.
    const int warmup_iters = num_sets;
    const int total_iters  = warmup_iters + cfg.iters;

    for (int it = 0; it < total_iters; ++it) {
        const int s = it % num_sets;
        typename gemm_op_t::arguments_t gemm_arg_it(M, K, N, A_d_set[s], lda,
                B_d_set[s], ldb, C_d_set[s], ldc, ScaleB_d_set[s],
                ld_scale_b,
                reinterpret_cast<uint32_t *>(B_d_set[s]) + bitcos_signs_off,
                reinterpret_cast<uint32_t *>(B_d_set[s]) + bitcos_offsets_off,
                Acc_d, Cnt_d);
        double t0 = get_time_seconds();
        prof.cpu_start();
        auto e = queue.submit([&](handler &cgh) {
            cgh.parallel_for<kernel_name_t>(
                    nd_range, [=](nd_item<3> item) KERNEL_MAIN {
                        slm_barrier_init<gemm_op_t>();
                        gemm_op_t gemm_op;
                        gemm_op(item, gemm_arg_it);
                    });
        });
        e.wait();
        prof.cpu_end();
        prof.add_gpu_event(e);
        double t1 = get_time_seconds();
        if (it >= warmup_iters) {
            host_total_ms += (t1 - t0) * 1e3;
            auto sp = e.template get_profiling_info<
                    sycl::info::event_profiling::command_start>();
            auto en = e.template get_profiling_info<
                    sycl::info::event_profiling::command_end>();
            device_total_ns += static_cast<double>(en - sp);
            ++timed_iters;
        }
    }

    if (timed_iters > 0) {
        double avg_host_ms   = host_total_ms / timed_iters;
        double avg_device_ms = device_total_ns / 1e6 / timed_iters;
        double gflops_h      = (2.0 * M * K * N) / (avg_host_ms * 1e-3) / 1e9;
        double gflops_d      = (2.0 * M * K * N) / (avg_device_ms * 1e-3) / 1e9;

        // Memory traffic per GEMM (lower bound, assuming each matrix is read /
        // written exactly once; ignores cache reuse and slicing replays):
        //   A      : M*K * sizeof(fp16)            (read)
        //   B      : K/32 * N * sizeof(int1x32)
        //          = K*N/8 bytes                   (read; 1 bit per weight)
        //   C      : M*N * sizeof(fp16)            (write)
        //   ScaleB : K/gs * N * sizeof(fp16)       (read)
        const double bytes_a      = static_cast<double>(M) * K
                * sizeof(data_type_a);
        const double bytes_b      = static_cast<double>(K) * N / 8.0; // 1 bit/wt
        const double bytes_c      = static_cast<double>(M) * N
                * sizeof(data_type_c);
        const double bytes_scaleb = static_cast<double>(ks_groups) * N
                * sizeof(data_type_scale);
        const double bytes_total  = bytes_a + bytes_b + bytes_c + bytes_scaleb;

        // GiB/s (binary, 1024^3).
        constexpr double kGiB = 1024.0 * 1024.0 * 1024.0;
        double gbs_h = bytes_total / (avg_host_ms   * 1e-3) / kGiB;
        double gbs_d = bytes_total / (avg_device_ms * 1e-3) / kGiB;

        std::cout << std::fixed << std::setprecision(3)
                  << "Avg host  time: " << avg_host_ms   << " ms ("
                  << gflops_h << " GFLOPS, " << gbs_h << " GiB/s)\n"
                  << "Avg dev   time: " << avg_device_ms << " ms ("
                  << gflops_d << " GFLOPS, " << gbs_d << " GiB/s)\n"
                  << "Bytes/GEMM: " << bytes_total / (1024.0 * 1024.0)
                  << " MiB"
                  << "  (A=" << bytes_a / (1024.0 * 1024.0)
                  << ", B=" << bytes_b / (1024.0 * 1024.0)
                  << ", C=" << bytes_c / (1024.0 * 1024.0)
                  << ", ScaleB=" << bytes_scaleb / 1024.0 << " KiB)"
                  << "\n";
    }

    // ----- Validate -----
    // With distinct_sets, each set has its own gold reference; otherwise all
    // sets share gold[0] (and a stable bytewise-equal check fast-paths
    // sets >0).
    if (cfg.validate) {
        int passed = 0;
        int failed = 0;
        for (int s = 0; s < num_sets; ++s) {
            // Device matC has padded LD = ldc_padded; strip to logical N
            // on host. For M=1 this is just one transfer.
            if (ldc_padded == static_cast<uint32_t>(N)) {
                queue.memcpy(C_h, C_d_set[s],
                        size_c_host * sizeof(data_type_c)).wait();
            } else {
                for (int r = 0; r < M; ++r) {
                    queue.memcpy(C_h + static_cast<size_t>(r) * N,
                            C_d_set[s] + static_cast<size_t>(r) * ldc_padded,
                            static_cast<size_t>(N) * sizeof(data_type_c));
                }
                queue.wait();
            }
            const data_type_c *gold_C
                    = cfg.distinct_sets ? gold_C_set[s] : gold_C_set[0];
            std::string label = "int1 fp16 upcvt GEMM validation [set "
                    + std::to_string(s) + "/" + std::to_string(num_sets)
                    + "]";
            const bool verbose = (num_sets <= 4) || (s == 0);
            bool ok;
            if (verbose || cfg.distinct_sets) {
                ok = compare_against_gold<data_type_c>(C_h, gold_C, M, N,
                        label);
            } else {
                // Shared-init fast path: every set's C should match gold[0]
                // bytewise. Fall back to tolerance check on mismatch.
                bool bytewise_eq = (std::memcmp(C_h, gold_C,
                                            size_c_host * sizeof(data_type_c))
                        == 0);
                if (bytewise_eq) {
                    ok = true;
                } else {
                    ok = compare_against_gold<data_type_c>(C_h, gold_C,
                            M, N, label);
                }
            }
            (ok ? passed : failed)++;
            if (!ok) {
                std::cout << "FAILED at set " << s << "\n";
            }
        }
        std::cout << "Validation summary: " << passed << "/" << num_sets
                  << " sets PASSED";
        if (failed) std::cout << ", " << failed << " FAILED";
        std::cout << "\n";
        for (auto *g : gold_C_set) free(g, context);
    }

    // ----- Free -----
    free(A_h, context);
    free(B_h, context);
    free(C_h, context);
    free(ScaleB_h, context);
    for (int s = 0; s < num_sets; ++s) {
        free(A_d_set[s], context);
        free(B_d_set[s], context);
        free(C_d_set[s], context);
        free(ScaleB_d_set[s], context);
    }
    free(Acc_d, context);
    free(Cnt_d, context);
}

// Wrapper that dispatches between the aligned-N (block_2d on matB+matC) and
// arbitrary-N (block_1d per-row matB + unaligned_2d matC) compiled
// instantiations based on `matrix_n`. The aligned path requires:
//   - matB int1x32 (4B/elt): pitch-bytes %8  -> N %2.
//   - matC fp16   (2B/elt): pitch-bytes %8  -> N %4.
// So we take the aligned fast path when (N % 4 == 0); otherwise we use
// the arbitrary-N path which has zero driver-side LD padding (matB_ld =
// matC_ld = scale_ld = matrix_n).
template <int WGM, int WGN, int SGM, int SGN, int SGK, int KS = 1, int LS = 1>
void run_gemm_impl(const RunConfig &cfg) {
    if ((cfg.matrix_n % 4) == 0) {
        run_gemm_impl_inner<WGM, WGN, SGM, SGN, SGK, KS, LS,
                /*kUnaligned=*/false>(cfg);
    } else {
        run_gemm_impl_inner<WGM, WGN, SGM, SGN, SGK, KS, LS,
                /*kUnaligned=*/true>(cfg);
    }
}

// Run with the default tile config: wg_m=1, sg_m=1, sg_n=16, sg_k=128.
// (mma_xmx_m == sg_m == 1 makes XMX accept tile_size_m == 1.)
//
// M=1 (GEMV) tile selection, K=4096, tuned on Xe2 0xe223. Tiers match the
// int2 driver's N boundaries (4096 / 8192 / 16384) but with int1-specific
// (wg_n, KS, LS) winners (only B traffic differs vs int2: 1 bit/wt, K*N/8).
//   N <= 4096        : wg_n=32, KS=2, LS=4   -> ~231 GiB/s @ N=4096
//   4096 < N <= 8192 : wg_n=64, KS=1, LS=4   -> ~264-307 GiB/s
//   8192 < N <= 16384: wg_n=64, KS=1, LS=2   -> ~300-332 GiB/s
//   N > 16384        : wg_n=64, KS=1, LS=2   -> ~346 GiB/s @ N=32768
//
// Same wave-alignment dip story as int2: wg_n=128 only wins at multiples
// of 128 that are wave-aligned (12288, 16384) and loses 5-12% at
// off-aligned N (9216, 10240, 13312, 14336). wg_n=64 keeps the WG count
// high enough to fill multiple waves uniformly across the full range.
// Compared to int2's top tier (wg_n=128 KS=1), int1 prefers wg_n=64
// KS=1 LS=2 by 2-3% at large N -- the cheaper int1 dequant lets a
// 2-way SLM K-reduce stay net-positive at higher N.
// BITCOS runs every tier with KS=LS=1: the sign stream is a per-column
// bit run, so a subgroup that starts mid-K would need the population
// count of all preceding rows to locate its first sign bit. The (wg_n,
// KS, LS) numbers below are the inherited int1 tuning and no longer
// describe the tiers actually dispatched.
void run_gemm(const RunConfig &cfg) {
    // ----- Manual sweep override -----
    if (cfg.override_wg_n > 0) {
        const int W = cfg.override_wg_n;
        const int SN_ = cfg.override_sg_n;
        const int SK_ = cfg.override_sg_k;
#define DISPATCH(W_, SN, SK) \
    if (W == W_ && SN_ == SN && SK_ == SK) { \
        run_gemm_impl</*WGM*/1, /*WGN*/W_, /*SGM*/1, /*SGN*/SN, \
                /*SGK*/SK, /*KS*/1, /*LS*/1>(cfg); \
        return; \
    }
        DISPATCH(64, 16, 128)  DISPATCH(64, 32, 64)   DISPATCH(64, 32, 128)
        DISPATCH(128, 16, 128) DISPATCH(128, 32, 64)  DISPATCH(128, 32, 128)
        DISPATCH(256, 16, 128) DISPATCH(256, 32, 64)  DISPATCH(256, 32, 128)
        DISPATCH(64, 16, 64)   DISPATCH(128, 16, 64)  DISPATCH(256, 16, 64)
        DISPATCH(64, 16, 32)   DISPATCH(128, 16, 32)  DISPATCH(256, 16, 32)
#undef DISPATCH
        std::cerr << "Override (wg_n=" << W << " sg_n=" << SN_
                  << " sg_k=" << SK_ << ") not in dispatch grid\n";
        std::exit(1);
    }

    // For M=1, dispatch to one of four GEMV-tuned tiers based on N. For
    // M>1 the wider wg_n=128 is a small but consistent win.
    const bool gemv_tiny_n = (cfg.matrix_m == 1) && (cfg.matrix_n <= 4096);
    const bool gemv_mid_n  = (cfg.matrix_m == 1) && (cfg.matrix_n > 4096)
            && (cfg.matrix_n <= 8192);
    // M=1 above 8192: single tier wg_n=64 KS=1 LS=2 wins both the
    // upper-mid (8192 < N <= 16384) range AND the very-large N range
    // (>16384) on int1 (sweep across N in {9216, 10240, 11264, 12288,
    // 13312, 14336, 15360, 16384, 32768}).
    const bool gemv_upper_n = (cfg.matrix_m == 1) && (cfg.matrix_n > 8192);

    if (gemv_tiny_n) {
        run_gemm_impl</*WGM*/1, /*WGN*/32, /*SGM*/1, /*SGN*/16,
                /*SGK*/128, /*KS*/1, /*LS*/1>(cfg);
        return;
    }

    if (gemv_mid_n) {
        run_gemm_impl</*WGM*/1, /*WGN*/64, /*SGM*/1, /*SGN*/16,
                /*SGK*/128, /*KS*/1, /*LS*/1>(cfg);
        return;
    }

    if (gemv_upper_n) {
        // Retuned after the Xe2 bfe/bfn unpack reduced register movement.
        run_gemm_impl</*WGM*/1, /*WGN*/256, /*SGM*/1, /*SGN*/16,
                /*SGK*/64, /*KS*/1, /*LS*/1>(cfg);
        return;
    }

    // ----- M > 1 fallback (unchanged from int2 driver) -----
    constexpr int kWGN = 128;
    run_gemm_impl</*WGM*/1, /*WGN*/kWGN, /*SGM*/1, /*SGN*/16,
            /*SGK*/128, /*KS*/1>(cfg);
}

// ---------------------------------------------------------------------------
// Main

static void parse_int(const char *flag, const char *arg, int &out) {
    out = std::atoi(arg);
    if (out <= 0) {
        std::cerr << "Invalid value for " << flag << ": " << arg << "\n";
        std::exit(1);
    }
}

int main(int argc, char **argv) {
    RunConfig cfg;
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        if (a == "--m" && i + 1 < argc) parse_int("--m", argv[++i], cfg.matrix_m);
        else if (a == "--n" && i + 1 < argc) parse_int("--n", argv[++i], cfg.matrix_n);
        else if (a == "--k" && i + 1 < argc) parse_int("--k", argv[++i], cfg.matrix_k);
        else if (a == "--iters" && i + 1 < argc) parse_int("--iters", argv[++i], cfg.iters);
        else if (a == "--no-validate") cfg.validate = false;
        else if (a == "--pos-only") cfg.pos_only = true;
        else if (a == "--neg-only") cfg.neg_only = true;
        else if (a == "--sign-k-parity") cfg.sign_k_parity = true;
        else if (a == "--sign-n-parity") cfg.sign_n_parity = true;
        else if (a == "--sign-kp-parity") cfg.sign_kp_parity = true;
        else if (a.rfind("--z=", 0) == 0)
            cfg.zero_frac = std::stod(a.substr(4));
        else if (a == "--distinct-sets") cfg.distinct_sets = true;
        else if (a == "--sets" && i + 1 < argc)
            parse_int("--sets", argv[++i], cfg.num_sets);
        else if (a == "--min-footprint-gb" && i + 1 < argc) {
            cfg.min_footprint_gb = std::atof(argv[++i]);
            if (cfg.min_footprint_gb < 0.0) cfg.min_footprint_gb = 0.0;
        }
        else if (a == "--wg-n" && i + 1 < argc)
            parse_int("--wg-n", argv[++i], cfg.override_wg_n);
        else if (a == "--ks" && i + 1 < argc)
            parse_int("--ks", argv[++i], cfg.override_ks);
        else if (a == "--ls" && i + 1 < argc)
            parse_int("--ls", argv[++i], cfg.override_ls);
        else if (a == "--sg-n" && i + 1 < argc)
            parse_int("--sg-n", argv[++i], cfg.override_sg_n);
        else if (a == "--sg-k" && i + 1 < argc)
            parse_int("--sg-k", argv[++i], cfg.override_sg_k);
        else if (a == "-h" || a == "--help") {
            std::cout << "Usage: " << argv[0]
                      << " [--m M] [--n N] [--k K] [--iters N]"
                      << " [--no-validate] [--distinct-sets]"
                      << " [--sets N | --min-footprint-gb F]\n"
                      << "  --distinct-sets      : re-randomize A/B/ScaleB per"
                      << " set (each set validated against its own gold)\n"
                      << "  --sets N             : allocate N distinct device-side"
                      << " buffer sets and rotate over them\n"
                      << "  --min-footprint-gb F : auto-pick N so total footprint"
                      << " >= F GB (default 2.0)\n"
                      << "scale_gs is fixed at 128 (constexpr).\n"
                      << "Tile config: wg_m=1 sg_m=1 wg_n=128 sg_n=16 sg_k=128.\n";
            return 0;
        }
        else {
            std::cerr << "Unknown arg: " << a << "\n";
            return 1;
        }
    }
    run_gemm(cfg);
    return 0;
}
