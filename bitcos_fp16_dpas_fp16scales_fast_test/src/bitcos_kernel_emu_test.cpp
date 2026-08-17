// Host emulation of the kernel's dequantize inner sequence, checked against the
// packer. This exercises the parts the format self-test does not: the 64-bit
// window formed by the gather pair, the `w >>= present` consumption, and the
// low/high 16-row split, including the sh == 0 edge case of the double shift.

#include "bitcos_format.hpp"

#include <cstdio>
#include <cstdlib>
#include <random>
#include <vector>

int main(int argc, char **argv) {
    const size_t K = (argc > 1) ? std::strtoul(argv[1], nullptr, 10) : 1024;
    const size_t N = (argc > 2) ? std::strtoul(argv[2], nullptr, 10) : 64;

    int failures = 0;
    for (double z : {0.0, 0.3, 0.47, 0.85, 1.0}) {
        std::mt19937 rng(999);
        std::uniform_real_distribution<double> u(0.0, 1.0);
        std::vector<int8_t> codes(K * N);
        for (auto &c : codes)
            c = (u(rng) < z) ? 0 : ((u(rng) < 0.5) ? -1 : 1);

        std::vector<uint32_t> buf;
        bitcos::pack(codes.data(), K, N, buf);
        const uint32_t *bitmap = buf.data();
        const uint32_t *offsets = buf.data() + bitcos::offsets_word_base(K, N);
        const uint32_t *signs = buf.data() + bitcos::signs_word_base(K, N);

        size_t mismatches = 0;
        for (size_t n = 0; n < N; ++n) {
            uint32_t rank = 0;
            const uint32_t off = offsets[n];
            for (size_t kp = 0; kp < K / 32; ++kp) {
                const uint32_t bmp = bitmap[kp * N + n];

                // the two gathers the kernel issues, then the window
                const uint32_t lo = signs[off + (rank >> 5)];
                const uint32_t hi = signs[off + (rank >> 5) + 1];
                const uint32_t sh = rank & 31u;
                uint32_t w = (lo >> sh) | ((hi << (31u - sh)) << 1);

                for (uint32_t half = 0; half < 2; ++half) {
                    for (uint32_t c = 0; c < 16; ++c) {
                        const uint32_t present = (bmp >> (c + half * 16)) & 1u;
                        const uint16_t mag_mask
                                = static_cast<uint16_t>(0u - present);
                        const uint16_t sign_xor
                                = static_cast<uint16_t>((w & 1u) << 15);
                        // scale bits stand in for a +1.0 magnitude
                        const uint16_t scale_u16 = 0x3C00u; // fp16 1.0
                        const uint16_t out = (scale_u16 ^ sign_xor) & mag_mask;

                        const size_t kk = kp * 32 + half * 16 + c;
                        const int8_t expect = codes[kk * N + n];
                        int8_t got;
                        if (out == 0u) got = 0;
                        else if (out == 0x3C00u) got = 1;
                        else if (out == 0xBC00u) got = -1;
                        else got = 99;
                        if (got != expect) ++mismatches;

                        w >>= present;
                    }
                }
                rank += __builtin_popcount(bmp);
            }
        }
        std::printf("z=%.2f  mismatches=%zu  %s\n", z, mismatches,
                mismatches ? "FAIL" : "ok");
        if (mismatches) ++failures;
    }
    std::printf("%s\n", failures ? "KERNEL-EMU FAILED" : "KERNEL-EMU PASSED");
    return failures ? 1 : 0;
}
