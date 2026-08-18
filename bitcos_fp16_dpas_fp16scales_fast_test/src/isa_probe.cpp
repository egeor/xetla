// Probe which bit-manipulation patterns IGC fuses into single Xe instructions.
// Compile with IGC_ShaderDumpEnable and grep the .asm for bfn / bfe / cbit.
#include <sycl/sycl.hpp>
#include <sycl/ext/intel/esimd.hpp>

using namespace sycl;
using namespace sycl::ext::intel::esimd;

int main() {
    queue q{gpu_selector_v};
    uint32_t *p = malloc_device<uint32_t>(1024, q);
    q.parallel_for(nd_range<1>{range<1>(16), range<1>(16)},
             [=](nd_item<1>) SYCL_ESIMD_KERNEL {
                 simd<uint32_t, 16> a = block_load<uint32_t, 16>(p);
                 simd<uint32_t, 16> b = block_load<uint32_t, 16>(p + 16);
                 simd<uint32_t, 16> c = block_load<uint32_t, 16>(p + 32);

                 // 3-input boolean: candidate for bfn
                 simd<uint32_t, 16> r0 = (a ^ b) & c;
                 simd<uint32_t, 16> r1 = (a & b) | (~a & c);
                 simd<uint32_t, 16> r2 = a ^ (b & ~c);

                 // single-bit extract at a constant position: candidate for bfe
                 simd<uint32_t, 16> r3 = (a >> 7) & 1u;
                 // variable position
                 simd<uint32_t, 16> r4 = (a >> (b & 31u)) & 1u;
                 // mask synthesis from a bit
                 simd<uint32_t, 16> r5 = 0u - ((a >> 3) & 1u);
                 // popcount: known to fuse to cbit
                 simd<uint32_t, 16> v = a;
                 v = v - ((v >> 1) & 0x55555555u);
                 v = (v & 0x33333333u) + ((v >> 2) & 0x33333333u);
                 v = (v + (v >> 4)) & 0x0F0F0F0Fu;
                 simd<uint32_t, 16> r6 = (v * 0x01010101u) >> 24;
                 // rotate: candidate for rol
                 simd<uint32_t, 16> r7 = (a << 5) | (a >> 27);

                 block_store<uint32_t, 16>(p + 64, r0 + r1 + r2 + r3
                                 + r4 + r5 + r6 + r7);
             })
            .wait();
    free(p, q);
    return 0;
}
