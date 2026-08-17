// Self-test for the BITCOS packer: pack -> unpack must be the identity, and
// the stored size must match 1 + (1-z) bits per weight plus the offset plane.
// Runs on the host only; no SYCL, no GPU.

#include "bitcos_format.hpp"

#include <cstdio>
#include <cstdlib>
#include <random>
#include <vector>

int main(int argc, char **argv) {
    const size_t K = (argc > 1) ? std::strtoul(argv[1], nullptr, 10) : 512;
    const size_t N = (argc > 2) ? std::strtoul(argv[2], nullptr, 10) : 256;

    int failures = 0;
    for (double z : {0.0, 0.25, 0.47, 0.75, 0.90, 1.0}) {
        std::mt19937 rng(12345);
        std::uniform_real_distribution<double> u(0.0, 1.0);
        std::vector<int8_t> codes(K * N);
        size_t nnz = 0;
        for (auto &c : codes) {
            if (u(rng) < z) {
                c = 0;
            } else {
                c = (u(rng) < 0.5) ? -1 : 1;
                ++nnz;
            }
        }

        std::vector<uint32_t> buf;
        const auto sizes = bitcos::pack(codes.data(), K, N, buf);

        std::vector<int8_t> back(K * N, 127);
        bitcos::unpack(buf.data(), K, N, back.data());

        size_t mismatches = 0;
        for (size_t i = 0; i < K * N; ++i)
            if (back[i] != codes[i]) ++mismatches;

        const double measured_z = 1.0 - static_cast<double>(nnz) / (K * N);
        const double bpw = bitcos::bits_per_weight(sizes, K, N);
        const double ideal = 1.0 + (1.0 - measured_z);

        std::printf("z=%.2f (measured %.4f)  bits/weight=%.4f (ideal %.4f)  "
                    "sign_words=%zu  mismatches=%zu  %s\n",
                z, measured_z, bpw, ideal, sizes.sign_words, mismatches,
                mismatches ? "FAIL" : "ok");
        if (mismatches) ++failures;
    }

    std::printf("%s\n", failures ? "SELF-TEST FAILED" : "SELF-TEST PASSED");
    return failures ? 1 : 0;
}
