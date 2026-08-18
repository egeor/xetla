// Standalone probe: BITCOS GEMV with plain vector FMA instead of DPAS.
// Lanes are columns, k is the outer loop, so the dequantized value is consumed
// immediately and never materialised into a VNNI accumulator tile.
#include <sycl/sycl.hpp>
#include <sycl/ext/intel/esimd.hpp>
#include <sycl/ext/intel/experimental/esimd/math.hpp>

#include <cstdio>
#include <cstdlib>
#include <random>
#include <string>
#include <vector>

#include "bitcos_format.hpp"

using namespace sycl;
using namespace sycl::ext::intel::esimd;

static constexpr int kLanes = 16;
#ifdef FMA_FP16_ACC
using acc_t = half;
#else
using acc_t = float;
#endif

int main(int argc, char **argv) {
    int N = 32768, K = 16384, iters = 50;
    double z = 0.47;
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        if (a.rfind("--n=", 0) == 0) N = std::atoi(a.c_str() + 4);
        else if (a.rfind("--k=", 0) == 0) K = std::atoi(a.c_str() + 4);
        else if (a.rfind("--z=", 0) == 0) z = std::atof(a.c_str() + 4);
        else if (a.rfind("--iters=", 0) == 0) iters = std::atoi(a.c_str() + 8);
    }
    const int KP = K / 32;

    std::vector<int8_t> codes(size_t(K) * N);
    {
        std::mt19937 rng(20260817u);
        std::uniform_real_distribution<double> u(0.0, 1.0);
        for (auto &c : codes)
            c = (u(rng) < z) ? int8_t(0) : ((u(rng) < 0.5) ? int8_t(-1) : int8_t(1));
    }
    std::vector<uint32_t> buf;
    bitcos::pack(codes.data(), K, N, buf);
    buf.push_back(0u); // sign window reads one word past the last run
    const size_t off_base = bitcos::offsets_word_base(K, N);
    const size_t sgn_base = bitcos::signs_word_base(K, N);

    queue q{gpu_selector_v};
    std::printf("device: %s\n",
            q.get_device().get_info<sycl::info::device::name>().c_str());

    uint32_t *d_buf = malloc_device<uint32_t>(buf.size(), q);
    half *d_a = malloc_device<half>(K, q);
    half *d_scale = malloc_device<half>(N, q);
        acc_t *d_c = malloc_device<acc_t>(N, q);

    std::vector<half> ha(K), hs(N);
    {
        std::mt19937 rng(7u);
        std::uniform_real_distribution<float> u(-1.f, 1.f);
        for (auto &v : ha) v = half(u(rng));
        for (auto &v : hs) v = half(0.05f + 0.01f * u(rng));
    }
    q.memcpy(d_buf, buf.data(), buf.size() * 4).wait();
    q.memcpy(d_a, ha.data(), K * sizeof(half)).wait();
    q.memcpy(d_scale, hs.data(), N * sizeof(half)).wait();

    const uint32_t nblocks = N / kLanes;
    auto run = [&]() {
        return q.parallel_for(
                nd_range<1>{range<1>(nblocks), range<1>(32)},
                [=](nd_item<1> it) SYCL_ESIMD_KERNEL {
                    const uint32_t blk = it.get_global_id(0);
                    const uint32_t n0 = blk * kLanes;
                    const uint32_t *bitmap = d_buf;
                    const uint32_t *offs = d_buf + off_base;
                    const uint32_t *sgns = d_buf + sgn_base;

                    simd<uint32_t, kLanes> base
                            = block_load<uint32_t, kLanes>(offs + n0);
                    simd<uint32_t, kLanes> rank = 0;
                    simd<uint32_t, kLanes> scale32
                            = block_load<uint16_t, kLanes>(
                                      reinterpret_cast<const uint16_t *>(
                                              d_scale + n0));
                    simd<acc_t, kLanes> acc = acc_t(0);
                    using bfn_t = sycl::ext::intel::esimd::bfn_t;
                    constexpr bfn_t make_value
                            = (bfn_t::x ^ bfn_t::y) & bfn_t::z;
                    constexpr bfn_t advance_signs
                            = (bfn_t::x & bfn_t::z)
                            | (bfn_t::y & ~bfn_t::z);
                    simd<uint32_t, kLanes> bf_width = 1u;

                    for (int kp = 0; kp < KP; ++kp) {
                        simd<uint32_t, kLanes> bmp = block_load<uint32_t, kLanes>(
                                bitmap + size_t(kp) * N + n0);
                        simd<uint32_t, kLanes> byteoff
                                = (base + (rank >> 5)) << 2;
                        simd<uint32_t, kLanes> lo
                                = gather<uint32_t, kLanes>(sgns, byteoff);
                        simd<uint32_t, kLanes> hi = gather<uint32_t, kLanes>(
                                sgns, byteoff + 4);
                        simd<uint32_t, kLanes> sh = rank & 31u;
                        simd<uint32_t, kLanes> shn = (32u - sh) & 31u;
                        simd<uint32_t, kLanes> keep = 0u - ((0u - sh) >> 31);
                        simd<uint32_t, kLanes> w
                                = (lo >> sh) | ((hi << shn) & keep);

                        // const so operator[] yields the scalar, not a view
                        const simd<half, 32> av
                                = block_load<half, 32>(d_a + kp * 32);
#pragma unroll
                        for (int c = 0; c < 32; ++c) {
                            simd<uint32_t, kLanes> bf_offset = c;
                            simd<uint32_t, kLanes> mag
                                    = __esimd_sbfe<uint32_t, kLanes>(
                                            bf_width.data(), bf_offset.data(),
                                            bmp.data());
                            simd<uint32_t, kLanes> sgn = w << 15;
                            simd<uint32_t, kLanes> vb
                                    = bfn<make_value>(scale32, sgn, mag);
                            simd<uint16_t, kLanes> v16 = vb;
                            simd<half, kLanes> vh
                                    = v16.template bit_cast_view<half>();
                            const acc_t ak = static_cast<acc_t>(av[c]);
                            acc += ak * vh;
                            simd<uint32_t, kLanes> w_shifted = w >> 1;
                            w = bfn<advance_signs>(w_shifted, w, mag);
                        }
                        rank += cbit(bmp);
                    }
                    block_store<acc_t, kLanes>(d_c + n0, acc);
                });
    };

    run().wait();

        std::vector<acc_t> hc(N);
        q.memcpy(hc.data(), d_c, N * sizeof(acc_t)).wait();
    size_t bad = 0;
    for (int n = 0; n < N; ++n) {
        double ref = 0.0;
        for (int k = 0; k < K; ++k)
            ref += double(float(ha[k])) * codes[size_t(k) * N + n]
                    * double(float(hs[n]));
        double d = std::abs(ref - double(float(hc[n])));
        if (d > 0.05 * (std::abs(ref) + 1.0)) ++bad;
    }
    std::printf("mismatches: %zu / %d\n", bad, N);

    auto t0 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < iters; ++i) run();
    q.wait();
    auto t1 = std::chrono::high_resolution_clock::now();
    double ms = std::chrono::duration<double, std::milli>(t1 - t0).count()
            / iters;
    std::printf("FMA probe: %.4f ms  (DPAS kernel = 0.380 ms, int2 = 0.2256 ms)\n",
            ms);

    free(d_buf, q); free(d_a, q); free(d_scale, q); free(d_c, q);
    return 0;
}
