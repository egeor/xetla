#!/usr/bin/env bash
# Tune the int2 fp16-upconvert decode GEMV for the Bonsai 8B/27B shapes.
#
# Companion to ../bitcos_fp16_dpas_fp16scales_fast_test/tune_bonsai_shapes.sh
# so the two arms are tuned by the same method: best-of-N at 50 iters over a
# >=2 GB rotating footprint, not a single 20-iter pass. Comparing a tuned
# BITCOS against a default int2 flatters BITCOS, which is what this removes.
#
# int2 is a dense 2-bit code, so there is no zero-density knob.
set -u

BIN=${BIN:-./build/int2_fp16_upcvt_test}
OUT=${OUT:-int2_bonsai_tune.csv}
ITERS=${ITERS:-50}
REPS=${REPS:-3}
FOOTPRINT=${FOOTPRINT:-2.0}
PLAT=${PLAT:-unknown}

SHAPES_8B="qkv_proj:4096:6144 gate_up_proj:4096:24576 down_proj:12288:4096 lm_head:4096:151680"
SHAPES_27B="mlp.gate_up_proj:5120:34816 mlp.down_proj:17408:5120 linear_attn.in_proj_qkvz:5120:16384 linear_attn.out_proj:6144:5120 self_attn.qkv_proj:5120:14336 lm_head:5120:248320"
# Shapes as seen by the dispatcher at decode, not as stored in the IR: the
# plugin fuses q/k/v into one N=4096 GEMV and gate+up into N=12288, and pads
# the lm_head to 151680.
SHAPES_1P7B="qkv_proj:2048:4096 o_proj:2048:2048 gate_up_proj:2048:12288 down_proj:6144:2048 lm_head:2048:151680"
SHAPES_4B="qkv_proj:2560:6144 o_proj:4096:2560 gate_up_proj:2560:19456 down_proj:9728:2560 lm_head:2560:151680"

# (wg_n, KS, LS) combinations the int2 driver instantiates
CONFIGS="32:1:1 32:1:2 32:1:4 32:1:8 32:2:4 32:4:2 \
64:1:1 64:1:2 64:1:4 64:1:8 64:2:4 \
128:1:1 128:1:2 128:1:4 128:2:2 \
256:1:1 256:1:2"

printf 'platform,model,layer,k,n,wg_n,ks,ls,ms,gib_s,status\n' > "$OUT"

run_one() {  # $1 K  $2 N  $3 wg_n  $4 ks  $5 ls
    "$BIN" --m 1 --n "$2" --k "$1" --iters "$ITERS" \
        --min-footprint-gb "$FOOTPRINT" --no-validate \
        --wgn "$3" --ks "$4" --ls "$5" 2>&1 |
        sed -n 's/Avg dev   time: \([0-9.]*\) ms.*GFLOPS, \([0-9.]*\) GiB.*/\1 \2/p'
}

for model in ${MODELS_LIST:-8b 27b}; do
    eval "shapes=\$SHAPES_$(echo $model | tr a-z A-Z)"
    for s in $shapes; do
        IFS=: read -r name K N <<< "$s"
        best_ms=""; best_gb=""; best_cfg=""
        for cfg in $CONFIGS; do
            IFS=: read -r wgn ks ls <<< "$cfg"
            (( N % wgn != 0 )) && continue
            v=$(run_one "$K" "$N" "$wgn" "$ks" "$ls" >/dev/null 2>&1
                for _ in $(seq "$REPS"); do run_one "$K" "$N" "$wgn" "$ks" "$ls"; done |
                    sort -g | head -1)
            if [[ -z $v ]]; then
                echo "$PLAT,$model,$name,$K,$N,$wgn,$ks,$ls,nan,nan,failed" >> "$OUT"
                continue
            fi
            ms=${v%% *}; gb=${v##* }
            echo "$PLAT,$model,$name,$K,$N,$wgn,$ks,$ls,$ms,$gb,ok" >> "$OUT"
            if [[ -z $best_ms ]] || awk -v a="$ms" -v b="$best_ms" 'BEGIN{exit !(a<b)}'; then
                best_ms=$ms; best_gb=$gb; best_cfg="wg${wgn}/ks${ks}/ls${ls}"
            fi
        done
        printf '  %-4s %-26s K=%-6s N=%-7s best %-16s %s ms  %s GiB/s\n' \
            "$model" "$name" "$K" "$N" "$best_cfg" "$best_ms" "$best_gb"
    done
done
echo "wrote $OUT"
