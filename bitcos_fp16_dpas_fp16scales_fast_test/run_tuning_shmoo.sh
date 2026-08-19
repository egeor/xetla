#!/usr/bin/env bash
set -u

BIN_DIR=${BIN_DIR:-./build}
OUT=${OUT:-bitcos_tuning.csv}
ITERS=${ITERS:-20}
MIN_FOOTPRINT_GB=${MIN_FOOTPRINT_GB:-2.0}
Z=${Z:-0.40}

if [[ $# -ne 2 ]]; then
    echo "usage: $0 N K" >&2
    exit 2
fi
N=$1
K=$2

# Format: wg_n sg_n sg_k ls. The grid follows the 32-subgroup workgroup limit.
configs=(
    # sg_n=16: all sg_k=64 slicing ratios; neighboring K depths at the frontier.
    "32 16 64 1" "32 16 64 2" "32 16 64 4" "32 16 64 8" "32 16 64 16"
    "32 16 32 8" "32 16 128 8" "32 16 32 16" "32 16 128 16" "32 16 256 16"
    "64 16 64 1" "64 16 64 2" "64 16 64 4" "64 16 64 8"
    "64 16 32 4" "64 16 128 4" "64 16 32 8" "64 16 128 8" "64 16 256 8"
    "128 16 64 1" "128 16 64 2" "128 16 64 4"
    "128 16 32 2" "128 16 128 2" "128 16 32 4" "128 16 128 4" "128 16 256 4"
    "256 16 64 1" "256 16 64 2" "256 16 32 1" "256 16 128 1" "256 16 32 2" "256 16 128 2"
    "512 16 32 1" "512 16 64 1" "512 16 128 1"

    # sg_n=32: all sg_k=64 slicing ratios; neighboring K depths at the frontier.
    "32 32 64 1" "32 32 64 2" "32 32 64 4" "32 32 64 8" "32 32 64 16" "32 32 64 32"
    "32 32 32 16" "32 32 128 16"
    "64 32 64 4" "64 32 64 8" "64 32 64 16"
    "64 32 32 8" "64 32 128 8" "64 32 32 16" "64 32 128 16"
    "128 32 64 1" "128 32 64 2" "128 32 64 4" "128 32 64 8"
    "128 32 32 4" "128 32 128 4" "128 32 32 8" "128 32 128 8"
    "256 32 64 1" "256 32 64 2" "256 32 64 4"
    "256 32 32 2" "256 32 128 2" "256 32 32 4" "256 32 128 4"
    "512 32 64 1" "512 32 64 2" "512 32 32 1" "512 32 128 1" "512 32 32 2" "512 32 128 2"

    # Wide subgroup/workgroup probes.
    "256 64 64 8" "512 64 64 4" "1024 32 64 1" "1024 64 64 2"
)

printf 'n,k,z,wg_n,sg_n,sg_k,ls,time_ms,gib_s,status\n' > "$OUT"
for cfg in "${configs[@]}"; do
    read -r wg sn sk ls <<< "$cfg"
    if (( wg >= 1024 || sn >= 64 )); then
        group=5
    elif (( sn == 16 && wg <= 64 )); then
        group=1
    elif (( sn == 16 )); then
        group=2
    elif (( wg == 32 )); then
        group=3
    elif (( wg == 64 )); then
        if (( ls == 16 )); then
            group=6
        elif (( ls == 8 )); then
            group=7
        elif (( ls == 1 )); then
            group=8
        elif (( ls == 2 )); then
            group=9
        else
            group=10
        fi
    else
        group=4
    fi
    BIN="$BIN_DIR/bitcos_tune_g$group"
    output=$($BIN --m 1 --n "$N" --k "$K" --z="$Z" --iters "$ITERS" \
        --min-footprint-gb "$MIN_FOOTPRINT_GB" --no-validate \
        --wg-n "$wg" --sg-n "$sn" \
        --sg-k "$sk" --ks 1 --ls "$ls" 2>&1)
    rc=$?
    time_ms=$(sed -n 's/Avg dev   time: \([0-9.]*\) ms.*/\1/p' <<< "$output")
    gib_s=$(sed -n 's/Avg dev   time:.*GFLOPS, \([0-9.]*\) GiB\/s).*/\1/p' <<< "$output")
    if [[ $rc -eq 0 && -n "$time_ms" ]]; then
        status=ok
    else
        status=failed
        time_ms=${time_ms:-nan}
        gib_s=${gib_s:-nan}
    fi
    printf '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n' \
        "$N" "$K" "$Z" "$wg" "$sn" "$sk" "$ls" \
        "$time_ms" "$gib_s" "$status" | tee -a "$OUT"
done
