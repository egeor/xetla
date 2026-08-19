#!/usr/bin/env bash

# These setup scripts may return a nonzero status after successfully exporting
# their environment on some cluster images, so source them before `set -e`.
# shellcheck disable=SC1091
source /swtools/intel-gpu/latest/intel_gpu_vars.sh >/dev/null 2>&1 || true
# shellcheck disable=SC1091
source /swtools/intel/2026.0/oneapi-vars.sh --force >/dev/null 2>&1 || true

set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PLATFORM=""
SHAPE=both
BACKEND=opencl
ITERS=50
MIN_FOOTPRINT_GB=2.0

usage() {
    cat <<'EOF'
Usage: benchmark_bitcos_vs_int2_xe2.sh --platform b70|lnl [options]

Build and compare BITCOS against the apples-to-apples fixed int2 fp16-upcvt
baseline (fp16 activations, fp16 DPAS, one fp16 scale per 128 weights).

Options:
  --platform b70|lnl          Required; selects the recorded BITCOS tuning.
  --shape 8k|32k|both         Default: both.
  --backend opencl|level_zero Default: opencl (measured 1-2% faster).
  --iters N                   Timed iterations per run. Default: 50.
  --min-footprint-gb F        Rotating footprint. Default: 2.0.
  -h, --help                  Show this help.

Run this script inside an allocation containing the selected Xe2 GPU.
EOF
}

while (($#)); do
    case "$1" in
        --platform) PLATFORM=$2; shift 2 ;;
        --shape) SHAPE=$2; shift 2 ;;
        --backend) BACKEND=$2; shift 2 ;;
        --iters) ITERS=$2; shift 2 ;;
        --min-footprint-gb) MIN_FOOTPRINT_GB=$2; shift 2 ;;
        -h|--help) usage; exit 0 ;;
        *) echo "unknown argument: $1" >&2; usage >&2; exit 2 ;;
    esac
done

[[ $PLATFORM == b70 || $PLATFORM == lnl ]] || {
    echo "--platform must be b70 or lnl" >&2; exit 2;
}
[[ $SHAPE == 8k || $SHAPE == 32k || $SHAPE == both ]] || {
    echo "--shape must be 8k, 32k, or both" >&2; exit 2;
}
[[ $BACKEND == opencl || $BACKEND == level_zero ]] || {
    echo "--backend must be opencl or level_zero" >&2; exit 2;
}

export ONEAPI_DEVICE_SELECTOR="$BACKEND:gpu"
unset SYCL_PROGRAM_COMPILE_OPTIONS IGC_ShaderDumpEnable IGC_DumpToCustomDir

BITCOS_DIR="$ROOT/bitcos_fp16_dpas_fp16scales_fast_test"
INT2_DIR="$ROOT/int2_fp16_upcvt_dpas_fast_test"
BITCOS_BIN="$BITCOS_DIR/build/bitcos_tune_g2"
INT2_BIN="$INT2_DIR/build/int2_fp16_upcvt_test"

echo "Building BITCOS recorded-winner variants and int2 fp16-upcvt baseline..."
make -C "$BITCOS_DIR" build/bitcos_tune_g2 >/dev/null
make -C "$INT2_DIR" >/dev/null

echo "Device: $(sycl-ls 2>/dev/null | head -1)"
echo "Backend: $BACKEND; minimum rotating footprint: $MIN_FOOTPRINT_GB GB"

median_three() {
    printf '%s\n' "$1" "$2" "$3" | sort -n | sed -n '2p'
}

run_shape() {
    local label=$1 n=$2 k=$3 wg=$4 sn=$5 sk=$6 ls=$7
    local bitcos_times=() int2_times=() output time pass speedup

    echo
    echo "=== $label: M=1 N=$n K=$k z=0.40 ==="
    echo "BITCOS tuning: wg_n=$wg sg_n=$sn sg_k=$sk KS=1 LS=$ls"

    output=$($BITCOS_BIN --m 1 --n "$n" --k "$k" --z=0.40 --iters 1 \
        --sets 1 --wg-n "$wg" --sg-n "$sn" --sg-k "$sk" --ks 1 --ls "$ls")
    pass=$(sed -n 's/.*pass rate: \([0-9.]*%\).*/\1/p' <<< "$output")
    [[ $pass == 100.000% ]] || { echo "BITCOS validation failed: ${pass:-missing}"; exit 1; }

    output=$($INT2_BIN --m 1 --n "$n" --k "$k" --iters 1 --sets 1)
    pass=$(sed -n 's/.*pass rate: \([0-9.]*%\).*/\1/p' <<< "$output")
    [[ $pass == 100.000% ]] || { echo "int2 validation failed: ${pass:-missing}"; exit 1; }

    for run in 1 2 3; do
        output=$($BITCOS_BIN --m 1 --n "$n" --k "$k" --z=0.40 \
            --iters "$ITERS" --min-footprint-gb "$MIN_FOOTPRINT_GB" \
            --no-validate --wg-n "$wg" --sg-n "$sn" --sg-k "$sk" \
            --ks 1 --ls "$ls")
        time=$(sed -n 's/Avg dev   time: \([0-9.]*\) ms.*/\1/p' <<< "$output")
        bitcos_times+=("$time")

        output=$($INT2_BIN --m 1 --n "$n" --k "$k" --iters "$ITERS" \
            --min-footprint-gb "$MIN_FOOTPRINT_GB" --no-validate)
        time=$(sed -n 's/Avg dev   time: \([0-9.]*\) ms.*/\1/p' <<< "$output")
        int2_times+=("$time")
    done

    local bitcos_median int2_median
    bitcos_median=$(median_three "${bitcos_times[@]}")
    int2_median=$(median_three "${int2_times[@]}")
    speedup=$(awk -v base="$int2_median" -v test="$bitcos_median" \
        'BEGIN { printf "%.4f", base / test }')

    echo "BITCOS runs (ms): ${bitcos_times[*]}; median=$bitcos_median"
    echo "int2 runs   (ms): ${int2_times[*]}; median=$int2_median"
    echo "BITCOS speedup over int2: ${speedup}x"
}

if [[ $SHAPE == 8k || $SHAPE == both ]]; then
    # Both devices use this stable winner. A one-off LNL sg_n=32 result did not
    # reproduce under confirmation, so it is intentionally not selected.
    run_shape "8K x 8K" 8192 8192 128 16 64 4
fi

if [[ $SHAPE == 32k || $SHAPE == both ]]; then
    if [[ $PLATFORM == b70 ]]; then
        run_shape "32K x 16K" 32768 16384 512 16 64 1
    else
        run_shape "32K x 16K" 32768 16384 128 16 64 2
    fi
fi
