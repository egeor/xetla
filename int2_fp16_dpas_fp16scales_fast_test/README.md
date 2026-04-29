# int2 × fp16 DPAS GEMM driver — **fp16 scale tensors**

Standalone performance and correctness driver for the **int2 weight-only
quantized GEMM with fp16 activations and `DPAS` (XMX) int8 accumulation**
kernel
([include/experimental/group/gemm/impl/int2_fp16_dpas_xmx_xe.hpp](../include/experimental/group/gemm/impl/int2_fp16_dpas_xmx_xe.hpp)).

This variant is the fp16-scales counterpart of
[`int2_fp16_dpas_fast_test`](../int2_fp16_dpas_fast_test/): both `ScaleA`
(per-row activation scale) and `ScaleB` (per-column weight scale) are
stored in **fp16** instead of fp32, halving the bandwidth pressure on
the scale tensors. All on-chip arithmetic is still promoted to fp32
through the existing `elemwise_scale_output` paths.

## Operation under test

The kernel computes, in int8 XMX with fp32 elemwise rescaling and a final
fp16 cast:

$$
C_{m,n} \;=\; \mathrm{cast}_{fp16}\!\Bigg(
    \frac{1}{S^A_{g,m}}\,S^B_{g,n}
    \sum_{k=g\,K_g}^{(g+1)K_g-1}
        \mathrm{sat}_{int8}\!\big(S^A_{g,m}\cdot A_{m,k}\big)\;\cdot\;\mathrm{code}(B_{k,n})
\Bigg)
$$

where $K_g = K/g_s$ and the per-group **forward-quant** scale is
$S^A_{g,m} = 127 / \max_k|A_{m,k}|$.

| Tensor   | Type      | Layout                | Shape          |
| -------- | --------- | --------------------- | -------------- |
| `A`      | fp16      | row-major             | `[M, K]`       |
| `B`      | int2x16   | VNNI-16, K-packed     | `[K/16, N·16]` |
| `ScaleA` | **fp16**  | column-major (gs × M) | `[g_s, M]`     |
| `ScaleB` | **fp16**  | row-major   (gs × N)  | `[g_s, N]`     |
| `C`      | fp16      | row-major             | `[M, N]`       |

Codes are restricted to `{0, 1, 3}` ⇒ values `{0, +1, −1}` (code `2`,
which would map to `−2`, is skipped) so output magnitudes stay bounded
and host vs device fp32 reduction-order noise is minimal.

## Quick start

```bash
make -j                                                 # builds build/int2_fp16scales_test
./build/int2_fp16scales_test --mat_m=1 --mat_n=8192 --mat_k=8192 --iters=20
```

CLI (parsed in `main()` at the bottom of [src/main.cpp](src/main.cpp)):

```
--validation=0|1, -v0|-v1     enable/disable host gold compare      (default: on)
--mat_m=M / --mat_n=N / --mat_k=K   matrix dims                     (default: 1, 8192, 8192)
--global_kslicing={1,2,4,8}   GKS factor                            (default: 1)
--scale_gs=S                  runtime scale group count             (default: Test::scale_gs)
--external_scale_a_calc=1     scale-A calc mode                     (default: 1, ONLY supported)
--wg_m / --sg_m / --wg_n / --sg_n / --sg_k    pick precompiled tile (no recompile)
--iters=N / --num_iters=N     timed iterations                      (default: 20)
--bias / --enable_bias        fuse bias post-op
--silu / --enable_silu        fuse SiLU post-op
--help, -h                    full help
```

The figure of merit is `Average device GEMM time per set` /
`Average device GEMM Bandwidth per set`. The host figure adds SYCL
submit + wait overhead and is reported separately.

## Why a separate driver from `int2_fp16_dpas_fast_test`?

Three coupled reasons:

1. **scale storage dtype.** `using scale_dtype = fp16;` at the top of
   [src/main.cpp](src/main.cpp) flips both scale tensors to fp16. The
   kernel's `compute_policy_int2_fp16_dpas_xmx` is parameterized over
   `scale_dtype_a` / `scale_dtype_b`, so this just propagates through;
   compute is still fp32.
2. **`elemwise_scale_output` overload.** The original overload in
   [include/subgroup/tile/api.hpp](../include/subgroup/tile/api.hpp)
   required `T_scaleA::dtype == T_scaleB::dtype == float`. This branch
   widens the SFINAE clause to accept `fp16` for either or both scale
   tiles and converts to `interm_t = float` before the per-block
   reciprocal/multiply. The fp32 overload is unchanged for binary
   compatibility with `int2_fp16_dpas_fast_test`.
3. **internal-SLM scale-A path is locked to fp32.** The kslicing
   kernel's "compute scale_a in shared local memory" path
   ([include/experimental/kernel/gemm/impl/int2_fp16_dpas_kslicing_xe.hpp](../include/experimental/kernel/gemm/impl/int2_fp16_dpas_kslicing_xe.hpp))
   sizes its SLM scratchpad in `sizeof(float)` bytes. Letting this
   driver run with `--external_scale_a_calc=0` would have the GEMM read
   fp16 elements out of a float-sized scratchpad and produce NaNs. The
   CLI parser hard-rejects that mode (see `main()` in
   [src/main.cpp](src/main.cpp)); only `--external_scale_a_calc=1`
   (separate device kernel computes scale_a) is supported here.

## File layout

```
src/main.cpp                # driver, gold, all template instantiations
src/variant_common.hpp      # int2_dequant_base, dispatch, precompile tuple list
src/variant_registry.cpp    # populates std::vector<Variant> from the tuple list
src/precompiled_gemm.cpp    # carrier TU for explicit instantiations (link-time fan-out)
Makefile                    # icpx -fsycl, builds gtest from source
```

The split exists to keep recompilation cheap: changing the gold or CLI
in `main.cpp` does not retrigger the heavy SYCL device-IR pass on the
precompiled tile variants.

## Walkthrough of [src/main.cpp](src/main.cpp)

### 1. `absmax_to_inv_scale_reduction` ([src/main.cpp#L33](src/main.cpp#L33))

Per-row, per-group reducer that writes the **final forward-quant scale
`127/absmax`** directly into the device buffer with arbitrary output
dtype (fp16 here). It replaces the `absmax_row_reduction` helper from
[tests/unit/tile_row_reduction/kernel_func.hpp](../tests/unit/tile_row_reduction/kernel_func.hpp),
which writes raw absmax as float — incompatible with both this test's
fp16 scale storage and the GEMM's expectation that `scale_a` is already
the forward factor (the GEMM multiplies activations by `scale_a` and
saturates to int8, so it needs `127/absmax`, not its inverse).

The kernel uses a row-major `tile_t` of width `twidth`, runs `scale_gs`
ks-group iterations per row, prefetches one tile ahead, reduces with
`xetla_reduce<reduce_op::max>`, and casts the final scalar to
`out_dtype` before storing to `c_base[igs * sheight + row]`.

### 2. Configuration globals + N_SETS ([src/main.cpp#L121](src/main.cpp#L121))

Runtime knobs — `g_mat_m/n/k`, `g_global_kslicing`, `g_scale_gs`, the
`g_wg_*`/`g_sg_*` tile selectors, post-op flags, and
`g_external_scale_a_calc` — are plain globals declared `extern` from
[src/variant_common.hpp](src/variant_common.hpp). `N_SETS` is computed
in `calculate_n_sets_runtime()` to fill ~2 GB of device memory with
distinct buffer sets, which is what defeats Xe2 L2 caching and gives
honest DRAM-bandwidth numbers.

### 3. Host gold `gemm_result_validate` ([src/main.cpp#L208](src/main.cpp#L208))

An OpenMP-parallel quad loop that mirrors the kernel's compute order:

1. **Forward-quantize A** with truncation (RTZ) and saturate to int8 —
   matching ESIMD `xetla_sat<int8_t,float>` semantics.
2. For each `(i, j)`, accumulate `int8 × int8 → int32` per ks-group,
   then multiply by `scale_b * (1 / scale_a)` in fp32.
3. Apply optional bias and SiLU on the fp32 accumulator.
4. Cast to fp16 once at the end.

The comparator (`buff_cmp::xetla_buff_cmp`) accepts a sample if **any**
of `{abs_diff ≤ 8.0, ulp_diff ≤ 64, rel_diff ≤ 1%}` holds. These
tolerances are sized for the worst case at K=4096, fp32 reductions
across 32 ks-groups, and a single fp16 cast at the end.

### 4. `int2_dequantize_gemm_run` ([src/main.cpp#L327](src/main.cpp#L327))

The work-horse template. Parameterized over a `Test` policy struct (see
`int2_dequant_base` below) and the two compile-time post-op flags
`EnableBias` / `EnableSiLU`.

Stage breakdown:

* **Type plumbing.** Builds `tile_shape`, `compute_attr` (int8 XMX),
  `perf_tuning_knob`, `compute_policy_int2_fp16_dpas_xmx<…, scale_dtype,
  scale_dtype, mma_xmx_m, gpu_arch::Xe>`, and selects between
  `epilogue_policy_default` and `epilogue_policy_tile_op` based on the
  post-op flags. The dispatch policy is
  `dispatch_policy_int2_fp16_dpas_kslicing<…, use_external_scale_a>`
  with `use_external_scale_a == true` (only supported mode).
* **Allocation loop.** `n_sets` independent host+device buffer sets for
  `A, B, B_packed, C, Acc, Cnt, ScaleA, ScaleB` (and `Bias` if
  `EnableBias`).
* **A initialization with fake-quant round-trip.** Activations start as
  fp16 in `[-5, 5]`, then are forward-quantized to int8 using
  `lrintf(v * scale_a)` (round-to-nearest-even, matching ESIMD's RTE
  cast) and **dequantized back** so that the host buffer is bit-exact
  representable as `q / scale_a`. After the round-trip the per-group
  absmax may have shifted by one fp16 ULP, so `ScaleA_h` is recomputed
  from the modified A — otherwise the kernel's recomputed scale would
  drift one ULP from the host gold and produce systematic ~1% errors.
* **B initialization.** Random `uint32` masked so each 2-bit pair lands
  in `{00, 01, 11}` only — i.e. codes `{0, 1, 3}` mapping to
  `{0, +1, −1}`. Code `2 → −2` is excluded so partial sums stay bounded.
* **`ScaleA` is NOT copied to device.** It is recomputed every iteration
  by `absmax_to_inv_scale_reduction` writing into `ScaleA_d[set]`. Only
  `ScaleB` is `memcpy`'d (alongside `A`, `B`, `C`, `Acc`, `Cnt`, and
  optionally `Bias`).
* **Epilogue argument plumbing.** A lambda `create_epilogue_args`
  branches on `EnableBias` / `EnableSiLU` to build the right
  `chained_tile_op_t::arguments_t` (bias-only, silu-only, both, or
  default) so the `gemm_op_t::arguments_t` constructor is called with
  the right overload.
* **Kernel-bundle build.** Two distinct SYCL kernel name tags are
  registered through `kernel_name_t = gemm_kernel_wrapper<Test, …>` and
  `scale_kernel_128_t = compute_scale_kernel_wrapper<…, /*TILE_X=*/128>`
  (only `TILE_X = 128` is instantiated since with K=4096, `scale_gs=32`
  → `K_g = 128`). `setenv("SYCL_PROGRAM_COMPILE_OPTIONS", …)` injects
  the `-vc-codegen -doubleGRF -enableBCR …` finalizer flags before
  `build(inputBundle)`.
* **Iteration loop.** Per `iter`, per `set`:
  1. submit `absmax_to_inv_scale_reduction` (writes `ScaleA_d`),
  2. wait, then submit the GEMM kernel reading the freshly-written
     `ScaleA_d`.
  Iteration `0` is warmup (events are not collected). All other
  iterations contribute to `events_absmax`, `events_gemm`, and
  `events`. Final per-iteration / per-set times are derived from
  `command_start` / `command_end` profiling info on each event.
* **Validation.** Per set: unpack int2 codes back into a flat int8 `B`,
  copy `C` back from device, call `gemm_result_validate`. Then free
  everything.
* **Reporting.** Host avg time/BW/GFLOPS, device-only avg, device GEMM
  alone, device AbsMax alone, plus device efficiency
  `(device / host) * 100%`.

### 5. `run_int2_test_with_kslicing` + `find_and_run_selected_variant` ([src/main.cpp#L905](src/main.cpp#L905))

Variant lookup. The driver does **not** template the GEMM at run time;
instead `variant_registry.cpp` builds a `std::vector<Variant>` of the
seven precompiled tile shapes, each carrying a `std::function<void()>`
that calls the matching `int2_dequantize_gemm_run<…>` instantiation.
`find_and_run_selected_variant` matches the requested
`(wg_m, sg_m, wg_n, sg_n, sg_k, gks, is_gemv)` tuple and runs its
callable.

### 6. CLI parser + `main` ([src/main.cpp#L1024](src/main.cpp#L1024))

Hand-rolled argv loop using a `parse_uint64` lambda; each recognized
flag is parsed, the slot in `argv` is removed, and the loop index is
rewound so unknown args propagate to gtest. After parsing,
`N_SETS` is recalculated from final dimensions, and either the
default kslicing path or `find_and_run_selected_variant` is called
depending on whether any `--*g_*` tile flag was seen.

### 7. Explicit template instantiations ([src/main.cpp#L1216](src/main.cpp#L1216))

`INSTANTIATE_ALL_POSTOPS(GKS, WgM, SgM, WgN, SgN, SgK, XMXM, AccType, CType)`
expands to **four** explicit instantiations per tuple (one per
`(EnableBias, EnableSiLU)` combination) — all with
`UseExternalScaleA = true`, since the internal-SLM path is rejected at
runtime. The seven invocations at the bottom must match
`PRE_GEMM_TUPLES` in [src/variant_common.hpp](src/variant_common.hpp).

## Precompiled tile catalogue

Defined in [src/variant_common.hpp](src/variant_common.hpp) as
`PRE_GEMM_TUPLES`. All entries use `sg_m = 8`, `mma_xmx_m = 8`,
`GKS = 1`, `AccType = int32_t`, `CType = fp16`:

| `wg_m` | `sg_m` | `wg_n` | `sg_n` | `sg_k` |
| -----: | -----: | -----: | -----: | -----: |
|     64 |      8 |    128 |    128 |     32 |
|     32 |      8 |    256 |    128 |     64 |
|    256 |      8 |    160 |    160 |     32 |
|     32 |      8 |    160 |    160 |     32 |
|     64 |      8 |    160 |    160 |     32 |
|     64 |      8 |    256 |    128 |    128 |
|     64 |      8 |    256 |    128 |     64 |

`PRE_GEMV_TUPLES` is **empty** in this fp16-scales build. The GEMV
path needs a 1-element fp16 `block_load` specialization (the per-subgroup
`sg_m = 1` scale-A load) that is not declared `SYCL_EXTERNAL` in oneAPI
2025.3's `ESIMD memory.hpp`, so device compilation fails with
"SYCL kernel cannot call an undefined function without SYCL_EXTERNAL
attribute". For fp16-activation GEMV, use the float-scales sibling
[`int2_fp16_dpas_fast_test`](../int2_fp16_dpas_fast_test/) instead — its
fp32 scale storage triggers the 1-element `float` block_load, which
*is* available in this oneAPI build.

## Companion change in `include/subgroup/tile/api.hpp`

Two overloads are widened so this driver can pass fp16 scale tiles
through the existing elemwise paths:

* **`elemwise_scale_output`** — `T_scaleA::dtype` and `T_scaleB::dtype`
  may now each be either `float` or `fp16`. When `scaleB` is `fp16`,
  the tile is loaded as `xetla_vector<fp16, simd>` and converted to
  fp32 via `xetla_cvt<float, fp16, simd>` before the per-block
  multiply. `scaleA`'s reciprocal is taken in fp32 regardless of input
  dtype. `T_dst` may now also be `fp16` (in addition to `float` /
  `bf16`). The fp32-only overload remains for binary compatibility.
* **`elemwise_scale_fp16_to_int8`** — `T_scaleA::dtype` may now be
  `float` or `fp16`. Reciprocal and saturating cast still happen in
  fp32.

These are pure additions to the SFINAE clause; existing callers (the
fp32-scales test, bf16 paths) are unaffected.
