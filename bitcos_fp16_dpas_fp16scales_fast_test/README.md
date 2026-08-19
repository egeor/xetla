# BITCOS fp16-upcvt Xe2 benchmark

This driver benchmarks BITCOS ternary weights with fp16 activations, fp16 group
scales, fp32 accumulation, and fp16 XMX/DPAS. The comparison baseline is
`../int2_fp16_upcvt_dpas_fast_test`, which has the same arithmetic and one fp16
scale per 128 weights but stores fixed two-bit codes.

## Environment

```bash
source /swtools/intel-gpu/latest/intel_gpu_vars.sh
source /swtools/intel/2026.0/oneapi-vars.sh --force
export ONEAPI_DEVICE_SELECTOR=opencl:gpu
unset SYCL_PROGRAM_COMPILE_OPTIONS IGC_ShaderDumpEnable IGC_DumpToCustomDir
```

OpenCL measured 1-2% faster than Level Zero on both tested Xe2 devices. Use
`level_zero:gpu` when a deployment specifically requires that backend.

## Build and compare

From the XeTLA repository root:

```bash
./benchmark_bitcos_vs_int2_xe2.sh --platform b70 --shape both
./benchmark_bitcos_vs_int2_xe2.sh --platform lnl --shape both
```

The script builds the required BITCOS precompiled variants and the int2
fp16-upcvt baseline, validates both kernels, runs three repetitions, and uses a
rotating footprint of at least 2 GB by default.

Recorded stable BITCOS tunings at `z=0.40`:

| Platform | Shape | `wg_n` | `sg_n` | `sg_k` | LS |
|---|---:|---:|---:|---:|---:|
| B70 | 8192 x 8192 | 128 | 16 | 64 | 4 |
| B70 | 32768 x 16384 | 512 | 16 | 64 | 1 |
| LNL | 8192 x 8192 | 128 | 16 | 64 | 4 |
| LNL | 32768 x 16384 | 128 | 16 | 64 | 2 |

A broad-pass LNL 8K result favored `sg_n=32`, but it did not reproduce under
three 50-iteration confirmation runs; the stable `sg_n=16, LS=4` result is
recorded above.

## Tuning grid

```bash
make tuning
OUT=shmoo.csv MIN_FOOTPRINT_GB=2.0 ./run_tuning_shmoo.sh 8192 8192
```

The grid is split across `build/bitcos_tune_g1` through
`build/bitcos_tune_g10`. Splitting is necessary because the LNL IGC compiler
fails when too many high-pressure ESIMD variants are bundled into one binary.
The complete measured grids are stored in the four `shmoo_*.csv` files.

Two `wg_n=64, sg_n=32, sg_k=64` variants (LS1 and LS2) trigger an IGC internal
compiler error even when isolated; they are excluded from the runner. LS4, LS8,
and LS16 compile and run.
