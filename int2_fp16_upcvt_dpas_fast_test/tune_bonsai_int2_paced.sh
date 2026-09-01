#!/usr/bin/env bash
# Paced variant of tune_bonsai_int2.sh for the Lunar Lake part.
#
# Back-to-back sweeping drives this laptop-class device into a power-limited
# state where every tile collapses to ~31 GiB/s and the ranking is destroyed:
# down_proj 128/1/2 measures 76.7 GiB/s cold and 31.9 GiB/s inside an unpaced
# sweep. COOLDOWN between configs keeps it out of that state, and a canary
# re-measured every CANARY_EVERY configs records whether it stayed out.
#
# Rows carry the canary reading current at the time they were taken, so a
# contaminated stretch can be identified and dropped rather than silently used.
set -u

BIN=${BIN:-./build/int2_fp16_upcvt_test}
OUT=${OUT:-int2_bonsai_tune_paced.csv}
ITERS=${ITERS:-50}
REPS=${REPS:-3}
FOOTPRINT=${FOOTPRINT:-2.0}
PLAT=${PLAT:-unknown}
COOLDOWN=${COOLDOWN:-6}
CANARY_EVERY=${CANARY_EVERY:-5}
# Canary reference K=12288 N=4096 wg128/ks1/ls2. This is the WARM steady state,
# not the cold-start peak: the same config reads 76 GiB/s on a genuinely idle
# part and settles near 64 once the device has been driven for a minute. Decode
# runs sustained, so the warm figure is the representative one and the cold peak
# is what contaminates an unpaced sweep. The floor only catches the collapse to
# ~31 GiB/s that back-to-back running induces.
CANARY_REF=${CANARY_REF:-64.0}
CANARY_FLOOR=${CANARY_FLOOR:-0.85}

SHAPES_8B=${SHAPES_8B:-"qkv_proj:4096:6144 gate_up_proj:4096:24576 down_proj:12288:4096 lm_head:4096:151680"}
SHAPES_27B=${SHAPES_27B:-"mlp.gate_up_proj:5120:34816 mlp.down_proj:17408:5120 linear_attn.in_proj_qkvz:5120:16384 linear_attn.out_proj:6144:5120 self_attn.qkv_proj:5120:14336 lm_head:5120:248320"}

CONFIGS="32:1:1 32:1:2 32:1:4 32:1:8 32:2:4 32:4:2 \
64:1:1 64:1:2 64:1:4 64:1:8 64:2:4 \
128:1:1 128:1:2 128:1:4 128:2:2 \
256:1:1 256:1:2"

printf 'platform,model,layer,k,n,wg_n,ks,ls,ms,gib_s,canary_gibs,status\n' > "$OUT"

run_one() {  # $1 K  $2 N  $3 wg_n  $4 ks  $5 ls
    "$BIN" --m 1 --n "$2" --k "$1" --iters "$ITERS" \
        --min-footprint-gb "$FOOTPRINT" --no-validate \
        --wgn "$3" --ks "$4" --ls "$5" 2>&1 |
        sed -n 's/Avg dev   time: \([0-9.]*\) ms.*GFLOPS, \([0-9.]*\) GiB.*/\1 \2/p'
}

CANARY=0
measure_canary() {
    sleep "$COOLDOWN"
    local v
    v=$(run_one 12288 4096 128 1 2)
    CANARY=${v##* }
    [[ -z $CANARY ]] && CANARY=0
    awk -v c="$CANARY" -v r="$CANARY_REF" -v f="$CANARY_FLOOR" \
        'BEGIN{ if (c < r*f) printf "  [canary] %s GiB/s -- DEGRADED (<%.0f%% of %s), extending cooldown\n", c, f*100, r;
                else printf "  [canary] %s GiB/s ok\n", c }'
    # A degraded part needs far longer than the inter-config gap to recover.
    awk -v c="$CANARY" -v r="$CANARY_REF" -v f="$CANARY_FLOOR" 'BEGIN{exit !(c < r*f)}' && sleep 60
}

measure_canary
n=0
for model in ${MODELS_LIST:-8b 27b}; do
    eval "shapes=\$SHAPES_$(echo $model | tr a-z A-Z)"
    for s in $shapes; do
        IFS=: read -r name K N <<< "$s"
        best_ms=""; best_gb=""; best_cfg=""
        for cfg in $CONFIGS; do
            IFS=: read -r wgn ks ls <<< "$cfg"
            (( N % wgn != 0 )) && continue
            sleep "$COOLDOWN"
            v=$(run_one "$K" "$N" "$wgn" "$ks" "$ls" >/dev/null 2>&1
                for _ in $(seq "$REPS"); do run_one "$K" "$N" "$wgn" "$ks" "$ls"; done |
                    sort -g | head -1)
            if [[ -z $v ]]; then
                echo "$PLAT,$model,$name,$K,$N,$wgn,$ks,$ls,nan,nan,$CANARY,failed" >> "$OUT"
                continue
            fi
            ms=${v%% *}; gb=${v##* }
            echo "$PLAT,$model,$name,$K,$N,$wgn,$ks,$ls,$ms,$gb,$CANARY,ok" >> "$OUT"
            if [[ -z $best_ms ]] || awk -v a="$ms" -v b="$best_ms" 'BEGIN{exit !(a<b)}'; then
                best_ms=$ms; best_gb=$gb; best_cfg="wg${wgn}/ks${ks}/ls${ls}"
            fi
            n=$((n + 1))
            (( n % CANARY_EVERY == 0 )) && measure_canary
        done
        printf '  %-4s %-26s K=%-6s N=%-7s best %-16s %s ms  %s GiB/s\n' \
            "$model" "$name" "$K" "$N" "$best_cfg" "$best_ms" "$best_gb"
    done
done
echo "wrote $OUT"
