# int2 × fp16 upcvt GEMM/GEMV driver

Standalone performance and correctness driver for the **int2 weight-only
quantized GEMM with fp16 activations** kernel
([include/experimental/group/gemm/impl/int2_fp16_upcvt_xmx_xe.hpp](../include/experimental/group/gemm/impl/int2_fp16_upcvt_xmx_xe.hpp)).

The driver produces honest **DRAM-bandwidth** numbers on Xe2 by rotating
through many distinct device-side buffer sets to defeat L2, validates
against an OpenMP gold computed in the kernel's own fp32-accumulate /
fp16-cast order, and now supports **arbitrary `matrix_n`** with **zero
driver-side LD padding** (matB_ld = matC_ld = scale_ld = N).

## Operation under test

$$C_{m,n} \;=\; \mathrm{cast}_{fp16}\!\Bigg(\sum_{k=0}^{K-1} A_{m,k}
\cdot \mathrm{code}(B_{k,n}) \cdot S_{\lfloor k/g_s\rfloor,\,n}\Bigg)$$

| Tensor   | Type     | Layout                | Shape          |
| -------- | -------- | --------------------- | -------------- |
| `A`      | fp16     | row-major             | `[M, K]`       |
| `B`      | int2x16  | row-major, K-packed   | `[K/16, N]` (each `uint32` packs 16 K-codes for one N-column) |
| `ScaleB` | fp16     | row-major             | `[K/g_s, N]`   |
| `C`      | fp16     | row-major             | `[M, N]`       |

`g_s = 128` (compile-time, `kScaleGS`). Codes are restricted to
`{0, 1, 3}` ⇒ values `{0, +1, −1}`. Code `2` is intentionally excluded
so the kernel's bit-blend upconvert always emits an fp16 of magnitude 0
or 1 (no `−2` path needed in the hot loop).

## Quick start

```bash
make -j                                       # builds build/int2_fp16_upcvt_test
./build/int2_fp16_upcvt_test --m 1 --n 6144 --k 4096 --iters 50
```

CLI:

```
--m M                    matrix M             (default 32)
--n N                    matrix N             (default 4096)        # ANY positive value, no padding required
--k K                    matrix K             (default 4096)        # must be % 16 (int2x16 packing)
--iters N                timed iterations     (default 5)
--no-validate            skip the gold compare
--distinct-sets          re-randomize A/B/ScaleB per device buffer set
                         (each set validated against its own gold)
--sets N                 allocate N distinct device-side buffer sets
--min-footprint-gb F     auto-pick num_sets so total footprint >= F GB
                         (default 2.0)
```

The figure of merit is `Avg dev   time` GiB/s. The host figure adds
SYCL submit + wait overhead and is only included for sanity.

## Aligned-N vs arbitrary-N dispatch

Two compile-time specializations are instantiated for every tile shape;
[`run_gemm_impl`](src/main.cpp#L595) picks one at runtime per call:

| condition       | path              | matB load           | matC store     | scale load        |
| --------------- | ----------------- | ------------------- | -------------- | ----------------- |
| `N % 4 == 0`    | aligned (fast)    | `block_2d`          | `block_2d`     | `block_2d`        |
| otherwise       | arbitrary-N       | per-row `block_1d`  | `unaligned_2d` | `unaligned_2d`    |

The arbitrary-N path is selected via the
`compute_policy_int2_fp16_upcvt_xmx<…, use_unaligned_n_=true>` template
flag plus `epilogue_policy_unaligned`. The `int2_fp16_upcvt_kernel` SYCL
name tag carries `kUnaligned` so the two specializations get distinct
mangled names. **Driver LDs are unconditionally `matB_ld = matC_ld =
scale_ld = N`** in both paths — frameworks can hand surfaces through
unmodified.

How the unaligned path stays correct without padding:

* matB int2x16 (4 B/elt): the packed-row tile is 8 rows × 16 cols. The
  unaligned path replaces the single `block_2d` `tile_load` with an
  8-iter unrolled per-packed-row loop using `block_1d`. The row payload
  is built on a 1-elt-aligned `mem_desc_b` alias which forces the
  block_1d `mem_dtype` to `uint32_t` — that works for any 4-byte
  aligned `ldb` (block_2d would require `ldb % 2`, i.e. N even).
* matC fp16 (2 B/elt): `unaligned_2d` is OOB-checked per lane and has
  no pitch alignment requirement.
* scale fp16 (2 B/elt): switches to `unaligned_2d` on a 1-elt-aligned
  `mem_desc_scale` alias so per-lane fp16 loads handle any `scale_ld`.

A `static_assert` in the gemm impl pins the matB row payload's
`mem_dtype` to `uint32_t` so we cannot silently regress to `uint64_t`
(which would re-introduce an `ldb % 2` requirement).

## Walkthrough of [src/main.cpp](src/main.cpp)

### 1. Configuration & CLI ([L67](src/main.cpp#L67), [L695](src/main.cpp#L695))

`RunConfig` carries `m, n, k, iters, validate, num_sets,
min_footprint_gb, distinct_sets`. CLI parses each flag with
`parse_int`; unknown args exit 1.

### 2. Host gold reference ([L121](src/main.cpp#L121))

`compute_gold` is an OpenMP-parallel quad loop over `(i, j, gk, p)`.
Per scale-group:

1. `scale = (float)ScaleB[gk*ld_scale + j]`
2. accumulate `partial += A[i*K+ik] * bv` in **fp32** for all `p`
3. `accum += partial * scale` in **fp32**
4. cast to fp16 once at the end

This matches the kernel compute_policy
(`dtype_mma_acc = float`, fp32 accumulate, fp16 store) so accumulation
order is the only legitimate source of disagreement.

`int2_code_to_value` uses the `int8` shift-extend trick and handles all
four codes correctly even though only `{0, 1, 3}` are produced.

### 3. Comparator ([L152](src/main.cpp#L152))

Calls `xetla_buff_cmp` with:

| param            | value | meaning                                            |
| ---------------- | ----- | -------------------------------------------------- |
| `diff_elems_tol` | 0.001 | up to 0.1 % of elements may exceed the tolerances  |
| `ulp_tol`        | 64    | per-element fp16 ULP budget                        |
| `abs_tol`        | 8.0   | absorbs near-zero rel-err blow-ups                 |

Adequate for 2-bit weights with random scales up to ~16. The pass-rate
threshold is 99.9 %, so localized ULP outliers do not fail the run.

### 4. Type plumbing & kernel selection ([L166–L240](src/main.cpp#L166))

`run_gemm_impl_inner<WGM, WGN, SGM, SGN, SGK, KS, LS, kUnaligned>`:

- `dtype_mma_a = dtype_mma_b = fp16`, `dtype_mma_acc = float`,
  `dtype_scale = fp16`.
- Compute policy:
  `compute_policy_int2_fp16_upcvt_xmx<…, kScaleGS, /*mma_xmx_m=*/SGM,
  Xe, /*use_unaligned_n=*/kUnaligned>`. Forwarding `mma_xmx_m == sg_m`
  is what makes `SGM = 1` legal — the GEMV path needs it.
- Epilogue policy is `std::conditional_t<kUnaligned,
  epilogue_policy_unaligned<Xe>, epilogue_policy_default<Xe>>`.
- Dispatch:
  `dispatch_policy_int2_fp16_upcvt_kslicing<group_swizzle_default, KS,
  LS>`.
- The SYCL kernel name carries `<WGM,WGN,SGM,SGN,SGK,KS,LS,kUnaligned>`
  so each tile × path combo gets a distinct mangled name.

### 5. Cache-defeat via buffer-set rotation ([L255–L405](src/main.cpp#L255))

- `bytes_per_set = A + B + C + ScaleB` is computed once from the
  *unpadded* sizes (matB int2 storage = `K/16 * N` uint32, etc.).
- If `cfg.num_sets <= 0`,
  `num_sets = ⌈min_footprint_gb·1e9 / bytes_per_set⌉` (default 2 GB).
- For M=1, N=6144, K=4096 ⇒ `bytes_per_set ≈ 6.4 MiB`, **~310 sets**
  → working set ≫ GPU L2 (~64 MiB on Xe2).
- All sets share the same A/B/ScaleB unless `--distinct-sets`, in
  which case set 0 keeps the original init and sets 1..N each
  re-randomize **and** recompute their own gold reference.

This is what makes the timed loop measure actual DRAM-bound bandwidth.

### 6. Acc/Cnt scratch ([L420](src/main.cpp#L420))

A single shared `Acc_d`/`Cnt_d` (no per-set duplication). For `KS > 1`
those are global K-slice atomic-reduction scratch buffers; reuse across
sets is safe because the kernel is responsible for initializing
per-launch reduction state.

### 7. Argument validation ([L437](src/main.cpp#L437))

`gemm_op_t::can_implement(gemm_arg)` is called once before the timed
loop. `nd_range = gemm_op_t::get_nd_range(gemm_arg)`. SLM size and
barrier count are printed.

### 8. Timing loop ([L455–L490](src/main.cpp#L455))

```
total_iters = warmup_iters (= num_sets) + cfg.iters
```

- **Warm-up = num_sets**: every distinct device buffer is touched
  once (untimed) before timing → first-touch / page-fault costs
  excluded.
- For each timed iter: `s = it % num_sets` rotates through sets so
  consecutive iters hit different DRAM regions.
- Per-iter `gemm_arg_it` is rebuilt with that set's pointers — no
  aliasing.
- Wall time via `chrono::high_resolution_clock`; device time via
  SYCL `command_start` / `command_end` profiling info.
- Both `host_total_ms` and `device_total_ns` averaged.

### 9. Bandwidth accounting ([L495–L520](src/main.cpp#L495))

```
bytes_a      = M*K*sizeof(fp16)
bytes_b      = K*N/4               (2 bits per weight)
bytes_c      = M*N*sizeof(fp16)
bytes_scaleb = (K/gs)*N*sizeof(fp16)
bytes_total  = bytes_a + bytes_b + bytes_c + bytes_scaleb
gbs_d        = bytes_total / avg_device_ms / 2^30      (GiB/s, base-2)
```

Lower bound (each tensor read/written exactly once, ignoring KS
replays). For M=1, N=6144, K=4096:

| tensor  | bytes    |
| ------- | -------- |
| A       | 8 KiB    |
| B       | 6 MiB    |
| C       | 12 KiB   |
| ScaleB  | 384 KiB  |
| **sum** | ~6.4 MiB |

> When `KS > 1` the C-write is replicated KS× and reduced, but B is
> still read once per spatial tile. For GEMV the C term is negligible
> vs B, so the BW figure is honest to within a few %.
>
> When `LS > 1` (SLM K-reduce) the extra traffic is local SLM, not
> DRAM, so it is correctly excluded.

### 10. Validation pass ([L515–L560](src/main.cpp#L515))

Iterates all sets:

- Copies `C_d_set[s]` → `C_h` (matC has no padding now: a single
  `memcpy(M*N*sizeof(fp16))` per set, no row-stride dance).
- Shared init: bytewise `memcmp` against `gold[0]` first (fast path);
  on mismatch the tolerance comparator is run so a flaky tail set
  still gets diagnosed.
- `--distinct-sets`: tolerance comparator against `gold[s]` always.
- Verbose printing only for set 0 (or all sets when `num_sets <= 4`).
- Final summary `passed/total`.

### 11. Tile selection in `run_gemm` ([L623–L693](src/main.cpp#L623))

For **M = 1** (GEMV) the driver dispatches into 4 hand-tuned tiers
based on N. All tiers use `sg_n = 16` (HW caps `block_size_x_b`),
`sg_k = 128`, `sg_m = wg_m = 1`.

| N range            | wg_n | KS | LS | rationale                                                                  |
| ------------------ | ---: | -: | -: | -------------------------------------------------------------------------- |
| `N ≤ 4096`         |   32 |  2 |  4 | tiny-N: small WG-N tile + extra K-slicing fills the waves                  |
| `4096 < N ≤ 8192`  |   64 |  1 |  4 | `KS=1` avoids redundant atomic reductions in this regime                   |
| `8192 < N ≤ 16384` |   64 |  1 |  2 | `wg_n=128` has wave-alignment dips; `wg_n=64` smooths them                 |
| `N > 16384`        |  128 |  1 |  1 | default fallback in the switch                                             |

For `M > 1` it falls into the same switch with `KS` chosen by
`ks_for_n` (decreasing as N grows: 4 → 4 → 2 → 1).

The aligned/unaligned dispatch happens **inside** `run_gemm_impl`
(after tile selection), so each tier instantiates two specializations.

### 12. Things that look correct

- gold uses **fp32 accumulate then single fp16 cast**, matching the
  kernel epilogue.
- B-init uses
  `(r1 & 0x55555555) | ((r1 & r2 & 0x55555555) << 1)`, which produces
  only codes `{0, 1, 3}` uniformly — code 2 never occurs.
- ScaleB random in `[0.75, 15.75]`, all positive — sign noise comes
  only from the codes.
- A in `[−5, 5]` fp16 — no denormals, no infinities.
- `num_sets` defaults to a 2 GB working set → DRAM-bound timing.
- Warm-up = `num_sets` → page-faults excluded.
- Per-iter `gemm_arg_it` rebuilt → rotation hits a fresh set each iter.
- One shared Acc/Cnt is fine because the kernel inits per-launch
  reduction state.
- Zero LD padding in the driver: framework integration ready.

### 13. Caveats (not bugs)

1. `bytes_total` undercounts when `LS > 1` (SLM K-reduce) — that is
   local SLM, not DRAM, so the omission is correct for "bandwidth from
   DRAM".
2. `bytes_total` undercounts when `KS > 1` by a factor proportional
   to `KS·M·N·sizeof(fp16)` — for GEMV this term is tiny (12 KiB out
   of 6 MiB) so the BW number is honest.
3. Validation tolerance is generous (ulp_tol=64, abs_tol=8). For a
   2-bit weight kernel with up to 16 codes accumulated per group and
   scales up to ~16, single-element fp16 ULP errors of ±32–325 in
   near-zero cells can be normal. The pass-rate threshold is 99.9 %.
4. Arbitrary-N path runs at 60–95 % of the same-tier aligned path
   (block_1d serial loads + unaligned_2d are a few % less efficient
   than the block_2d fast path). When the caller can supply a padded
   N (or rounds the linear-layer width up at allocation time), the
   `N % 4 == 0` fast path will be selected automatically.

### 14. Verdict

The driver is sound for performance regression on int2-fp16-upcvt
GEMM/GEMV:

- Cache-defeat via multi-set rotation
- Page-fault-free warm-up
- Per-iter device profiling
- Memory traffic accounted as DRAM-bound lower bound
- Functional gold computed in the same fp32-accumulate-then-fp16-cast
  order as the kernel
- Per-set validation with both fast bytewise and tolerance fallback
- Tile / KS / LS selection encoded with measured rationale in
  comments, gated on M=1 vs M>1 and on N range
- Aligned/unaligned auto-dispatch with zero driver-side LD padding

Use **`Avg dev`'s GiB/s** as the figure of merit — it excludes host
submit/wait overhead and corresponds 1:1 to DRAM traffic over
device-clock time.

## Reference numbers

Xe2, ~64 Xe-cores, K = 4096, M = 1, 20 timed iters, 2 GB working set.
Validation tolerance: 100 % pass-rate at the listed N.

### Aligned-N (`N % 4 == 0`, block_2d everywhere)

| N      | GiB/s | notes                                |
| -----: | ----: | ------------------------------------ |
|   4096 |   323 | wg_n=32, KS=2, LS=4                  |
|   6144 |   380 | wg_n=64, KS=1, LS=4                  |
|   8192 |   400 | wg_n=64, KS=1, LS=4                  |
|  12288 |   408 | wg_n=64, KS=1, LS=2                  |
|  16384 |   427 | wg_n=64, KS=1, LS=2                  |

### Arbitrary-N (block_1d matB + unaligned_2d matC/scale, **zero pad**)

| N       | GiB/s | notes                            |
| ------: | ----: | -------------------------------- |
|    4097 |   256 | tier 1 (wg_n=32)                 |
|    6145 |   290 | tier 2 (wg_n=64)                 |
|    8193 |   300 | tier 2 (wg_n=64)                 |
|   12289 |   355 | tier 3 (wg_n=64)                 |
|  151699 |   410 | tier 4 (wg_n=128)                |

### Historical: aligned-path optimization (`4f0eb28`, "u16-width unpack + XOR sign blend")

| N      | baseline GiB/s | optimized GiB/s | Δ        |
| -----: | -------------: | --------------: | -------: |
|   4096 |          270.8 |       **323.5** | +19.5 %  |
|   6144 |          297.5 |       **379.9** | +27.7 %  |
|   8192 |          308.8 |       **399.0** | +29.2 %  |
|  12288 |          309.0 |       **408.0** | +32.0 %  |
|  16384 |          323.5 |       **429.2** | +32.7 %  |
