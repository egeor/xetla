/// BITCOS: bitmap + column offsets + compacted signs, for ternary weights.
///
/// One device buffer holds three planes back to back. The first two have sizes
/// fixed by (K, N), so the kernel derives all three pointers from the base:
///
///   [0                      , K*N/32          )  bitmap   uint32
///   [K*N/32                 , K*N/32 + N      )  offsets  uint32
///   [K*N/32 + N             , ...             )  signs    uint32 bitstream
///
/// bitmap[kp*N + n] bit c  = "weight (k = kp*32 + c, n) is non-zero".
/// offsets[n]              = word index where column n's sign run starts.
/// signs                   = one bit per non-zero, column-major, in increasing
///                           k; each column's run starts word-aligned so the
///                           offset is a word index and the kernel's running
///                           rank stays inside the column.
///
/// The kernel walks k from 0 upwards, so it carries a per-column running rank
/// exactly like the CPU kernel carries `bitpos`, instead of recomputing a
/// prefix popcount per weight (there is no pdep on Xe).

#pragma once

#include <algorithm>
#include <cstdint>
#include <cstddef>
#include <vector>

namespace bitcos {

// k values whose presence bits share one bitmap word
inline constexpr uint32_t kBitsPerWord = 32;

struct Sizes {
    size_t bitmap_words;  // K*N/32
    size_t offset_words;  // N
    size_t sign_words;    // data dependent
    size_t total_words;
};

inline size_t bitmap_words_of(size_t k, size_t n) {
    return (k / kBitsPerWord) * n;
}

/// Byte offsets of the three planes inside the single buffer.
inline size_t offsets_word_base(size_t k, size_t n) { return bitmap_words_of(k, n); }
inline size_t signs_word_base(size_t k, size_t n) { return bitmap_words_of(k, n) + n; }

/// Pack a dense ternary matrix.
/// @param codes  [k][n] row-major, values in {-1, 0, +1}
/// @param out    receives the whole buffer (bitmap, offsets, signs)
inline Sizes pack(const int8_t *codes, size_t k, size_t n,
        std::vector<uint32_t> &out) {
    const size_t bmp_words = bitmap_words_of(k, n);
    const size_t off_base = offsets_word_base(k, n);
    const size_t sgn_base = signs_word_base(k, n);

    // column n contributes popcount(column n) sign bits, padded to a word
    std::vector<uint32_t> nnz(n, 0);
    for (size_t kk = 0; kk < k; ++kk)
        for (size_t nn = 0; nn < n; ++nn)
            if (codes[kk * n + nn] != 0) ++nnz[nn];

    std::vector<uint32_t> col_word(n, 0);
    size_t running = 0;
    for (size_t nn = 0; nn < n; ++nn) {
        col_word[nn] = static_cast<uint32_t>(running);
        running += (nnz[nn] + kBitsPerWord - 1) / kBitsPerWord;
    }
    const size_t sign_words = running;

    out.assign(sgn_base + sign_words, 0u);

    for (size_t nn = 0; nn < n; ++nn) out[off_base + nn] = col_word[nn];

    // bitmap
    for (size_t kk = 0; kk < k; ++kk) {
        const size_t kp = kk / kBitsPerWord;
        const uint32_t c = static_cast<uint32_t>(kk % kBitsPerWord);
        for (size_t nn = 0; nn < n; ++nn)
            if (codes[kk * n + nn] != 0) out[kp * n + nn] |= (1u << c);
    }

    // signs, column-major: bit r of column nn is the sign of its r-th non-zero
    std::vector<uint32_t> rank(n, 0);
    for (size_t kk = 0; kk < k; ++kk) {
        for (size_t nn = 0; nn < n; ++nn) {
            const int8_t v = codes[kk * n + nn];
            if (v == 0) continue;
            const uint32_t r = rank[nn]++;
            if (v < 0)
                out[sgn_base + col_word[nn] + (r / kBitsPerWord)]
                        |= (1u << (r % kBitsPerWord));
        }
    }

    return Sizes{bmp_words, n, sign_words, out.size()};
}

/// Prefix sign ranks for K-sliced execution. Row s-1 stores the number of
/// nonzeros before slice s; slice zero always starts at rank zero.
inline void pack_slice_ranks(const int8_t *codes, size_t k, size_t n,
        uint32_t slices, std::vector<uint32_t> &out) {
    if (slices <= 1) {
        out.clear();
        return;
    }
    const size_t slice_k = (k + slices - 1) / slices;
    std::vector<uint32_t> rank(n, 0);
    out.assign(static_cast<size_t>(slices - 1) * n, 0);
    uint32_t next_slice = 1;
    for (size_t kk = 0; kk < k; ++kk) {
        while (next_slice < slices && kk == next_slice * slice_k) {
            std::copy(rank.begin(), rank.end(),
                    out.begin() + static_cast<size_t>(next_slice - 1) * n);
            ++next_slice;
        }
        for (size_t nn = 0; nn < n; ++nn)
            rank[nn] += codes[kk * n + nn] != 0;
    }
}

/// Host mirror of the kernel unpack: rebuild the dense ternary matrix.
/// Written in the same running-rank style the kernel uses, so it exercises the
/// same invariant rather than just inverting `pack`.
inline void unpack(const uint32_t *buf, size_t k, size_t n, int8_t *codes) {
    const uint32_t *bitmap = buf;
    const uint32_t *offsets = buf + offsets_word_base(k, n);
    const uint32_t *signs = buf + signs_word_base(k, n);

    std::vector<uint32_t> rank(n, 0);
    for (size_t kp = 0; kp < k / kBitsPerWord; ++kp) {
        for (size_t nn = 0; nn < n; ++nn) {
            const uint32_t bmp = bitmap[kp * n + nn];
            const uint32_t *col = signs + offsets[nn];
            uint32_t r = rank[nn];
            for (uint32_t c = 0; c < kBitsPerWord; ++c) {
                const size_t kk = kp * kBitsPerWord + c;
                if (!((bmp >> c) & 1u)) {
                    codes[kk * n + nn] = 0;
                    continue;
                }
                const uint32_t bit = (col[r / kBitsPerWord] >> (r % kBitsPerWord)) & 1u;
                codes[kk * n + nn] = bit ? -1 : 1;
                ++r;
            }
            rank[nn] = r;
        }
    }
}

/// Bits per weight actually stored, for reporting against the 2.125 of int2.
inline double bits_per_weight(const Sizes &s, size_t k, size_t n) {
    return static_cast<double>(s.total_words) * 32.0 / static_cast<double>(k * n);
}

} // namespace bitcos
