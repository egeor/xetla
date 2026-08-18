// Standalone probe: cost of the BITCOS unpack when the destination is a native
// 2-bit DPAS operand (s2, VNNI-16) instead of an fp16 VNNI-2 tile.
//
// Xe2 XMX takes dpas_argument_type::s2 natively, which is why the int2 kernel
// runs at 0.2256 ms with literally no dequantize: it reinterprets the packed
// weights and feeds them to the systolic array. BITCOS cannot do that (the sign
// stream is variable rate) but it can aim at the same *destination format*, and
// 2 bits/weight instead of 16 makes the per-weight work collapse.
//
// The blocker is that placing variable-rate sign bits into fixed 2-bit slots is
// pdep, which Xe2 has no instruction for. This probe emulates pdep with a
// 256-entry SLM table indexed by (bitmap nibble, next 4 sign bits); the entry
// carries both the 4 finished s2 fields and the number of sign bits consumed,
// so one gather retires magnitude, sign and stream advance together.
//
// Both variants walk identical memory (same bitmap words, same sign gathers),
// so the delta is purely unpack ALU. Each folds its produced tile words into a
// checksum with one op per word, which is what the real kernel spends on the
// VNNI store, so neither variant is flattered.
#include <sycl/sycl.hpp>
#include <sycl/ext/intel/esimd.hpp>
#include <sycl/ext/intel/experimental/esimd/math.hpp>

#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <random>
#include <string>
#include <vector>

#include "bitcos_format.hpp"

using namespace sycl;
using namespace sycl::ext::intel::esimd;

static constexpr int kLanes = 16;   // 16 columns per work item
static constexpr int kWgSize = 32;  // work items per group
static constexpr int kTblBytes = 256 * 4;

// entry[(m4 << 4) | s4] = s2 fields for 4 k-rows | popcount(m4) << 24
static uint32_t lut_entry(uint32_t m4, uint32_t s4) {
    uint32_t out = 0, r = 0;
    for (uint32_t i = 0; i < 4; ++i) {
        if (!((m4 >> i) & 1u)) continue;
        const uint32_t neg = (s4 >> r) & 1u;
        ++r;
        out |= (neg ? 3u : 1u) << (2 * i); // s2: 00 = 0, 01 = +1, 11 = -1
    }
    return out | (r << 24);
}

/// fp16 table: four half-precision ternary codes for four k-rows, 8 B/entry.
///
/// The bit trick the current kernel uses, (scale ^ sgn) & mag, needs *two*
/// 16-bit fields per weight, because no single-operand function of scale can
/// reach all three outcomes: AND gives +1 and 0 but cannot set the sign bit.
/// A multiply needs only one field, so a d64 gather covers four rows, and it
/// runs on the float pipe which the int-only unpack leaves completely idle.
static void fp16_lut_entry(uint32_t m4, uint32_t s4, uint16_t *dst) {
    uint32_t r = 0;
    for (uint32_t i = 0; i < 4; ++i) {
        if (!((m4 >> i) & 1u)) {
            dst[i] = 0x0000;
            continue;
        }
        dst[i] = ((s4 >> r) & 1u) ? 0xBC00 : 0x3C00; // -1.0h : +1.0h
        ++r;
    }
}

int main(int argc, char **argv) {
    int N = 32768, K = 16384, iters = 50;
    double z = 0.40;
    bool alu_only = false;
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        if (a.rfind("--n=", 0) == 0) N = std::atoi(a.c_str() + 4);
        else if (a.rfind("--k=", 0) == 0) K = std::atoi(a.c_str() + 4);
        else if (a.rfind("--z=", 0) == 0) z = std::atof(a.c_str() + 4);
        else if (a.rfind("--iters=", 0) == 0) iters = std::atoi(a.c_str() + 8);
        else if (a == "--alu-only") alu_only = true;
    }
    const int KP = K / 32;

    std::vector<int8_t> codes(size_t(K) * N);
    {
        std::mt19937 rng(20260817u);
        std::uniform_real_distribution<double> u(0.0, 1.0);
        for (auto &c : codes)
            c = (u(rng) < z) ? int8_t(0)
                             : ((u(rng) < 0.5) ? int8_t(-1) : int8_t(1));
    }
    std::vector<uint32_t> buf;
    const auto sizes = bitcos::pack(codes.data(), K, N, buf);
    buf.push_back(0u); // the sign window reads one word past the last run
    const size_t off_base = bitcos::offsets_word_base(K, N);
    const size_t sgn_base = bitcos::signs_word_base(K, N);

    std::vector<uint32_t> tbl(256);
    for (uint32_t m4 = 0; m4 < 16; ++m4)
        for (uint32_t s4 = 0; s4 < 16; ++s4)
            tbl[(m4 << 4) | s4] = lut_entry(m4, s4);

    std::vector<uint16_t> ftbl(256 * 4);
    for (uint32_t m4 = 0; m4 < 16; ++m4)
        for (uint32_t s4 = 0; s4 < 16; ++s4)
            fp16_lut_entry(m4, s4, &ftbl[(((m4 << 4) | s4)) * 4]);

    queue q{gpu_selector_v};
    std::printf("device: %s\n",
            q.get_device().get_info<sycl::info::device::name>().c_str());
    std::printf("N=%d K=%d z=%.2f  bits/weight=%.5f\n", N, K, z,
            bitcos::bits_per_weight(sizes, K, N));

    uint32_t *d_buf = malloc_device<uint32_t>(buf.size(), q);
    uint32_t *d_tbl = malloc_device<uint32_t>(256, q);
    uint32_t *d_ftbl = malloc_device<uint32_t>(256 * 2, q);
    uint32_t *d_chk = malloc_device<uint32_t>(size_t(N) * 2, q);
    uint32_t *d_const = malloc_device<uint32_t>(96, q);
    half *d_scale = malloc_device<half>(N, q);

    std::vector<half> hs(N);
    {
        std::mt19937 rng(7u);
        std::uniform_real_distribution<float> u(-1.f, 1.f);
        for (auto &v : hs) v = half(0.05f + 0.01f * u(rng));
    }
    q.memcpy(d_buf, buf.data(), buf.size() * 4).wait();
    q.memcpy(d_tbl, tbl.data(), 256 * 4).wait();
    q.memcpy(d_ftbl, ftbl.data(), 256 * 4 * sizeof(uint16_t)).wait();
    q.memcpy(d_scale, hs.data(), N * sizeof(half)).wait();

    std::vector<uint32_t> consts(96);
    for (int i = 0; i < 16; ++i) {
        consts[i] = 0x3C0u;      // bitmap nibble slot in the table index
        consts[16 + i] = 0x3Cu;  // sign nibble slot in the table index
        consts[32 + i] = 0x00FFFFFFu; // clear the popcount field for lane 0
        consts[64 + i] = 0x780u; // same two slots for the 8 B fp16 entries
        consts[80 + i] = 0x78u;
    }
    q.memcpy(d_const, consts.data(), 96 * 4).wait();
    const uint32_t nblocks = N / kLanes;
    const int Nc = N, KPc = KP;
    const size_t offb = off_base, sgnb = sgn_base;
    // --alu-only walks a 4-word window of the bitmap and folds every sign
    // gather into 16 KB, so all of B stays L1 resident and what is left is the
    // unpack ALU. Results are meaningless; timing is the point.
    const uint32_t kp_mask = alu_only ? 3u : 0xFFFFFFFFu;
    const uint32_t sg_mask = alu_only ? 0x3FFFu : 0xFFFFFFFFu;

    using bfn_t = sycl::ext::intel::esimd::bfn_t;
    // (scale ^ sign) & present  -- the current 3-input value builder
    constexpr bfn_t make_value = (bfn_t::x ^ bfn_t::y) & bfn_t::z;
    // present ? (w >> 1) : w    -- consume a sign bit only where one exists
    constexpr bfn_t advance_signs = (bfn_t::x & bfn_t::z) | (bfn_t::y & ~bfn_t::z);
    // (a & mask) | acc
    constexpr bfn_t merge_masked = (bfn_t::x & bfn_t::y) | bfn_t::z;

    // ---- variant A: current unpack, fp16 VNNI-2 destination ----------------
    auto run_fp16 = [&]() {
        return q.parallel_for(nd_range<1>{range<1>(nblocks), range<1>(kWgSize)},
                [=](nd_item<1> it) SYCL_ESIMD_KERNEL {
                    const uint32_t n0 = it.get_global_id(0) * kLanes;
                    const uint32_t *bitmap = d_buf;
                    const uint32_t *offs = d_buf + offb;
                    const uint32_t *sgns = d_buf + sgnb;

                    simd<uint32_t, kLanes> base
                            = block_load<uint32_t, kLanes>(offs + n0);
                    simd<uint32_t, kLanes> rank = 0;
                    simd<uint32_t, kLanes> scale32 = block_load<uint16_t, kLanes>(
                            reinterpret_cast<const uint16_t *>(d_scale + n0));
                    simd<uint32_t, kLanes> chk = 0;
                    simd<uint32_t, kLanes> bf_width = 1u;

                    for (int kp = 0; kp < KPc; ++kp) {
                        simd<uint32_t, kLanes> bmp
                                = block_load<uint32_t, kLanes>(
                                        bitmap + size_t(kp & kp_mask) * Nc + n0);
                        simd<uint32_t, kLanes> byteoff
                                = ((base + (rank >> 5)) << 2) & sg_mask;
                        simd<uint32_t, kLanes> lo
                                = gather<uint32_t, kLanes>(sgns, byteoff);
                        simd<uint32_t, kLanes> hi
                                = gather<uint32_t, kLanes>(sgns, byteoff + 4);
                        simd<uint32_t, kLanes> sh = rank & 31u;
                        simd<uint32_t, kLanes> shn = (32u - sh) & 31u;
                        simd<uint32_t, kLanes> keep = 0u - ((0u - sh) >> 31);
                        simd<uint32_t, kLanes> w
                                = (lo >> sh) | ((hi << shn) & keep);
#pragma unroll
                        for (int c = 0; c < 32; ++c) {
                            simd<uint32_t, kLanes> bf_offset = c;
                            simd<uint32_t, kLanes> mag
                                    = __esimd_sbfe<uint32_t, kLanes>(
                                            bf_width.data(), bf_offset.data(),
                                            bmp.data());
                            simd<uint32_t, kLanes> sgn = w << 15;
                            simd<uint32_t, kLanes> v
                                    = bfn<make_value>(scale32, sgn, mag);
                            chk ^= v; // stands in for the VNNI store mov
                            simd<uint32_t, kLanes> w_shifted = w >> 1;
                            w = bfn<advance_signs>(w_shifted, w, mag);
                        }
                        rank += cbit(bmp);
                    }
                    block_store<uint32_t, kLanes>(d_chk + n0, chk);
                });
    };

    // ---- variant B: LUT pdep, native s2 VNNI-16 destination ----------------
    auto run_s2 = [&]() {
        return q.parallel_for(nd_range<1>{range<1>(nblocks), range<1>(kWgSize)},
                [=](nd_item<1> it) SYCL_ESIMD_KERNEL {
                    slm_init<kTblBytes>();
                    const uint32_t lid = it.get_local_id(0);
                    if (lid < 16) {
                        simd<uint32_t, 16> t
                                = block_load<uint32_t, 16>(d_tbl + lid * 16);
                        slm_block_store<uint32_t, 16>(lid * 16 * 4, t);
                    }
                    barrier();

                    const uint32_t n0 = it.get_global_id(0) * kLanes;
                    const uint32_t *bitmap = d_buf;
                    const uint32_t *offs = d_buf + offb;
                    const uint32_t *sgns = d_buf + sgnb;

                    simd<uint32_t, kLanes> base
                            = block_load<uint32_t, kLanes>(offs + n0);
                    simd<uint32_t, kLanes> rank = 0;
                    simd<uint32_t, kLanes> chk = 0;
                    // Masks come from memory so IGC cannot see that they fit in
                    // 16 bits. With immediates it narrows the chain to :w and
                    // then spends three movs per nibble repacking stride-2 words
                    // back to dwords, which costs more than the work itself.
                    const simd<uint32_t, kLanes> c_idx
                            = block_load<uint32_t, kLanes>(d_const);      // 0x3C0
                    const simd<uint32_t, kLanes> c_wp
                            = block_load<uint32_t, kLanes>(d_const + 16); // 0x3C
                    const simd<uint32_t, kLanes> c_q0
                            = block_load<uint32_t, kLanes>(d_const + 32); // 0xFFFFFF

                    for (int kp = 0; kp < KPc; ++kp) {
                        simd<uint32_t, kLanes> bmp
                                = block_load<uint32_t, kLanes>(
                                        bitmap + size_t(kp & kp_mask) * Nc + n0);
                        simd<uint32_t, kLanes> byteoff
                                = ((base + (rank >> 5)) << 2) & sg_mask;
                        simd<uint32_t, kLanes> lo
                                = gather<uint32_t, kLanes>(sgns, byteoff);
                        simd<uint32_t, kLanes> hi
                                = gather<uint32_t, kLanes>(sgns, byteoff + 4);
                        simd<uint32_t, kLanes> sh = rank & 31u;
                        simd<uint32_t, kLanes> shn = (32u - sh) & 31u;
                        simd<uint32_t, kLanes> keep = 0u - ((0u - sh) >> 31);
                        simd<uint32_t, kLanes> w
                                = (lo >> sh) | ((hi << shn) & keep);

                        // one bitmap word covers 32 k-rows = two s2 dwords
#pragma unroll
                        for (int h = 0; h < 2; ++h) {
                            simd<uint32_t, kLanes> acc;
#pragma unroll
                            for (int qq = 0; qq < 4; ++qq) {
                                const int b = h * 16 + qq * 4;
                                // land the bitmap nibble on index bits 6..9;
                                // one of the two shifts is always zero and
                                // folds away
                                const unsigned sl = (b <= 6) ? unsigned(6 - b) : 0u;
                                const unsigned sr = (b <= 6) ? 0u : unsigned(b - 6);
                                simd<uint32_t, kLanes> tsh = (bmp << sl) >> sr;
                                // and the next 4 sign bits on index bits 2..5
                                simd<uint32_t, kLanes> wp = (w << 2) & c_wp;
                                simd<uint32_t, kLanes> off
                                        = bfn<merge_masked>(tsh, c_idx, wp);
                                simd<uint32_t, kLanes> e
                                        = slm_gather<uint32_t, kLanes>(off);
                                // The entry is (s2 byte) | popcount << 24, so
                                // shifting it into byte lane qq >= 1 already
                                // pushes the popcount field off the top; only
                                // lane 0 has to mask it off.
                                if (qq == 0) acc = e & c_q0;
                                else acc |= e << (8 * qq);
                                w = w >> (e >> 24); // advance by popcount(m4)
                            }
                            chk ^= acc; // stands in for the VNNI store mov
                        }
                        rank += cbit(bmp);
                    }
                    block_store<uint32_t, kLanes>(d_chk + n0, chk);
                });
    };

    // ---- variant C: LUT pdep, fp16 VNNI-2 destination via float-pipe mul ----
    // Same destination format and same numerics as variant A, so this one is a
    // drop-in for the existing upcvt kernel: no int8 activations, no epilogue
    // rework. The table holds +-1.0h / 0.0h, so one d64 gather retires four
    // rows and the value is a multiply on the otherwise idle float pipe.
    auto run_fp16_lut = [&]() {
        return q.parallel_for(nd_range<1>{range<1>(nblocks), range<1>(kWgSize)},
                [=](nd_item<1> it) SYCL_ESIMD_KERNEL {
                    slm_init<2048>();
                    const uint32_t lid = it.get_local_id(0);
                    if (lid < 32) {
                        simd<uint32_t, 16> t
                                = block_load<uint32_t, 16>(d_ftbl + lid * 16);
                        slm_block_store<uint32_t, 16>(lid * 16 * 4, t);
                    }
                    barrier();

                    const uint32_t n0 = it.get_global_id(0) * kLanes;
                    const uint32_t *bitmap = d_buf;
                    const uint32_t *offs = d_buf + offb;
                    const uint32_t *sgns = d_buf + sgnb;

                    simd<uint32_t, kLanes> base
                            = block_load<uint32_t, kLanes>(offs + n0);
                    simd<uint32_t, kLanes> rank = 0;
                    simd<uint32_t, kLanes> chk_a = 0, chk_b = 0;
                    const simd<uint32_t, kLanes> c_idx
                            = block_load<uint32_t, kLanes>(d_const + 64); // 0x780
                    const simd<uint32_t, kLanes> c_wp
                            = block_load<uint32_t, kLanes>(d_const + 80); // 0x78

                    // a VS=2 gather returns transposed data: element 0 of every
                    // lane, then element 1, so the scale repeats per dword half
                    simd<half, kLanes> sc = block_load<half, kLanes>(d_scale + n0);
                    simd<half, kLanes * 4> sc_rep;
                    sc_rep.template select<kLanes, 2>(0) = sc;
                    sc_rep.template select<kLanes, 2>(1) = sc;
                    sc_rep.template select<kLanes, 2>(kLanes * 2) = sc;
                    sc_rep.template select<kLanes, 2>(kLanes * 2 + 1) = sc;

                    for (int kp = 0; kp < KPc; ++kp) {
                        simd<uint32_t, kLanes> bmp
                                = block_load<uint32_t, kLanes>(
                                        bitmap + size_t(kp & kp_mask) * Nc + n0);
                        simd<uint32_t, kLanes> byteoff
                                = ((base + (rank >> 5)) << 2) & sg_mask;
                        simd<uint32_t, kLanes> lo
                                = gather<uint32_t, kLanes>(sgns, byteoff);
                        simd<uint32_t, kLanes> hi
                                = gather<uint32_t, kLanes>(sgns, byteoff + 4);
                        simd<uint32_t, kLanes> sh = rank & 31u;
                        simd<uint32_t, kLanes> shn = (32u - sh) & 31u;
                        simd<uint32_t, kLanes> keep = 0u - ((0u - sh) >> 31);
                        simd<uint32_t, kLanes> w
                                = (lo >> sh) | ((hi << shn) & keep);

#pragma unroll
                        for (int g = 0; g < 8; ++g) {
                            const int b = g * 4;
                            // entries are 8 B, so the bitmap nibble lands on
                            // index bits 7..10 and the sign nibble on 3..6
                            const unsigned sl = (b <= 7) ? unsigned(7 - b) : 0u;
                            const unsigned sr = (b <= 7) ? 0u : unsigned(b - 7);
                            simd<uint32_t, kLanes> tsh = (bmp << sl) >> sr;
                            simd<uint32_t, kLanes> wp = (w << 3) & c_wp;
                            simd<uint32_t, kLanes> m4 = tsh & c_idx;
                            simd<uint32_t, kLanes> off
                                    = bfn<merge_masked>(tsh, c_idx, wp);
                            simd<uint32_t, kLanes * 2> e
                                    = slm_gather<uint32_t, kLanes * 2, 2>(off);
                            simd<half, kLanes * 4> code
                                    = e.template bit_cast_view<half>();
                            simd<half, kLanes * 4> v = code * sc_rep;
                            simd<uint32_t, kLanes * 2> vd
                                    = v.template bit_cast_view<uint32_t>();
                            chk_a ^= vd.template select<kLanes, 1>(0);
                            chk_b ^= vd.template select<kLanes, 1>(kLanes);
                            w = w >> cbit(m4);
                        }
                        rank += cbit(bmp);
                    }
                    block_store<uint32_t, kLanes>(d_chk + n0, chk_a);
                    block_store<uint32_t, kLanes>(d_chk + Nc + n0, chk_b);
                });
    };

    auto check = [&](const char *name, auto &&launch, auto &&host_ref) {        launch().wait();
        std::vector<uint32_t> got(N);
        q.memcpy(got.data(), d_chk, N * sizeof(uint32_t)).wait();
        size_t bad = 0;
        for (int n = 0; n < N; ++n)
            if (got[n] != host_ref(n)) ++bad;
        std::printf("%-6s checksum mismatches: %zu / %d\n", name, bad, N);
        return bad;
    };

    auto ref_fp16 = [&](int n) {
        const uint32_t sc = *reinterpret_cast<const uint16_t *>(&hs[n]);
        uint32_t c = 0;
        for (int k = 0; k < K; ++k) {
            const int8_t v = codes[size_t(k) * N + n];
            c ^= (v == 0) ? 0u : (sc ^ (v < 0 ? 0x8000u : 0u));
        }
        return c;
    };
    auto ref_s2 = [&](int n) {
        uint32_t c = 0;
        for (int k = 0; k < K; k += 16) {
            uint32_t d = 0;
            for (int i = 0; i < 16; ++i) {
                const int8_t v = codes[size_t(k + i) * N + n];
                d |= (v == 0 ? 0u : (v < 0 ? 3u : 1u)) << (2 * i);
            }
            c ^= d;
        }
        return c;
    };

    // the fp16 LUT writes two planes: rows 4g+0,4g+1 and rows 4g+2,4g+3
    auto check_fp16_lut = [&]() {
        run_fp16_lut().wait();
        std::vector<uint32_t> got(size_t(N) * 2);
        q.memcpy(got.data(), d_chk, size_t(N) * 2 * sizeof(uint32_t)).wait();
        size_t bad = 0;
        for (int n = 0; n < N; ++n) {
            const uint32_t sc = *reinterpret_cast<const uint16_t *>(&hs[n]);
            auto val = [&](int k) -> uint32_t {
                const int8_t v = codes[size_t(k) * N + n];
                return v == 0 ? 0u : (v < 0 ? (sc ^ 0x8000u) : sc);
            };
            uint32_t ca = 0, cb = 0;
            for (int k = 0; k < K; k += 4) {
                ca ^= val(k) | (val(k + 1) << 16);
                cb ^= val(k + 2) | (val(k + 3) << 16);
            }
            if (got[n] != ca || got[size_t(N) + n] != cb) ++bad;
        }
        std::printf("%-6s checksum mismatches: %zu / %d\n", "f16lut", bad, N);
        return bad;
    };

    // The fp16 variant is a timing reference only: it leaves the sign stream's
    // upper bits in bits 16..31, which the real kernel discards on the u16 VNNI
    // store, so its checksum is not expected to match the host model. Only the
    // s2 path is gated on correctness here.
    size_t bad = 0;
    if (!alu_only) {
        check("fp16", run_fp16, ref_fp16);
        bad = check("s2", run_s2, ref_s2);
        bad += check_fp16_lut();
    }

    auto bench = [&](const char *name, auto &&launch) {
        for (int i = 0; i < 5; ++i) launch();
        q.wait();
        auto t0 = std::chrono::high_resolution_clock::now();
        for (int i = 0; i < iters; ++i) launch();
        q.wait();
        auto t1 = std::chrono::high_resolution_clock::now();
        double ms = std::chrono::duration<double, std::milli>(t1 - t0).count()
                / iters;
        std::printf("%-6s unpack: %.4f ms\n", name, ms);
        return ms;
    };

    double a = bench("fp16", run_fp16);
    double b = bench("s2", run_s2);
    double c = bench("f16lut", run_fp16_lut);
    std::printf("speedup vs fp16:  s2 %.2fx   f16lut %.2fx\n", a / b, a / c);
    std::printf("(DPAS kernel 0.380 ms, int2 ref 0.2256 ms, "
                "BITCOS memory floor 0.181 ms)\n");

    free(d_buf, q); free(d_tbl, q); free(d_ftbl, q); free(d_chk, q);
    free(d_const, q); free(d_scale, q);
    return bad == 0 ? 0 : 1;
}
