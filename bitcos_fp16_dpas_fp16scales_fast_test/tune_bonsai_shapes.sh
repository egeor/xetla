#!/usr/bin/env bash
# Tune the BITCOS decode GEMV for the Bonsai 8B/27B shapes.
#
# Unlike run_tuning_shmoo.sh this takes best-of-N at 50 iters rather than a
# single 20-iter pass: at these margins a single pass reports the same config
# up to 3% apart and cannot rank tiles reliably.
#
# LS=2 is included even though the vllm plugin cannot currently dispatch it,
# to quantify what adding that branch would be worth.
set -u

BIN_DIR=${BIN_DIR:-./build}
OUT=${OUT:-bonsai_tune.csv}
Z=${Z:-0.40}
ITERS=${ITERS:-50}
REPS=${REPS:-3}
FOOTPRINT=${FOOTPRINT:-2.0}
PLAT=${PLAT:-unknown}
SGKS=${SGKS:-64}

# name:K:N  (M=1 decode shapes)
SHAPES_8B=${SHAPES_8B:-"qkv_proj:4096:6144 gate_up_proj:4096:24576 down_proj:12288:4096 lm_head:4096:151680"}
SHAPES_27B=${SHAPES_27B:-"mlp.gate_up_proj:5120:34816 mlp.down_proj:17408:5120 linear_attn.in_proj_qkvz:5120:16384 linear_attn.out_proj:6144:5120 self_attn.qkv_proj:5120:14336 lm_head:5120:248320"}

printf 'platform,model,layer,k,n,wg_n,sg_k,ls,ms,gib_s,status\n' > "$OUT"

run_one() {  # $1 bin  $2 K  $3 N  $4 wg_n  $5 ls  $6 sg_k
    "$1" --m 1 --n "$3" --k "$2" --z="$Z" --iters "$ITERS" \
        --min-footprint-gb "$FOOTPRINT" --no-validate \
        --wg-n "$4" --sg-n 16 --sg-k "$6" --ks 1 --ls "$5" 2>&1 |
        sed -n 's/Avg dev   time: \([0-9.]*\) ms.*GFLOPS, \([0-9.]*\) GiB.*/\1 \2/p'
}

for model in 8b 27b; do
    eval "shapes=\$SHAPES_$(echo $model | tr a-z A-Z)"
    for s in $shapes; do
        IFS=: read -r name K N <<< "$s"
        best_ms=""; best_gb=""; best_cfg=""
        for wgn in 32 64 128 256; do
            (( N % wgn != 0 )) && continue
            for sgk in $SGKS; do
            for ls in 1 2 4 8; do
                (( wgn / 16 * ls > 64 )) && continue
                # no single group instantiates every tile, so try each
                found=""
                for grp in 1 2 11; do
                    BIN="$BIN_DIR/bitcos_tune_g$grp"
                    [[ -x $BIN ]] || continue
                    if [[ -n $(run_one "$BIN" "$K" "$N" "$wgn" "$ls" "$sgk" 2>/dev/null) ]]; then
                        found=$BIN; break
                    fi
                done
                if [[ -z $found ]]; then
                    echo "$PLAT,$model,$name,$K,$N,$wgn,$sgk,$ls,nan,nan,failed" >> "$OUT"
                    continue
                fi
                BIN=$found
                v=$(for _ in $(seq "$REPS"); do run_one "$BIN" "$K" "$N" "$wgn" "$ls" "$sgk"; done |
                        sort -g | head -1)
                if [[ -z $v ]]; then
                    echo "$PLAT,$model,$name,$K,$N,$wgn,$sgk,$ls,nan,nan,failed" >> "$OUT"
                    continue
                fi
                ms=${v%% *}; gb=${v##* }
                echo "$PLAT,$model,$name,$K,$N,$wgn,$sgk,$ls,$ms,$gb,ok" >> "$OUT"
                if [[ -z $best_ms ]] || awk -v a="$ms" -v b="$best_ms" 'BEGIN{exit !(a<b)}'; then
                    best_ms=$ms; best_gb=$gb; best_cfg="wg${wgn}/k${sgk}/ls${ls}"
                fi
            done
            done
        done
        printf '  %-6s %-26s K=%-6s N=%-7s best %-12s %s ms  %s GiB/s\n' \
            "$model" "$name" "$K" "$N" "$best_cfg" "$best_ms" "$best_gb"
    done
done
echo "wrote $OUT"
