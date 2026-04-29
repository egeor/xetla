/*******************************************************************************
* Copyright (c) 2022-2023 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

/// @file
/// C++ API

#pragma once

#include "subgroup/tile/common.hpp"

namespace gpu::xetla::subgroup {

/// @brief Is the xetla tile mma operation definition API.
/// @tparam matAcc_dst_t Is the tile type for dst data of matC.
/// @tparam matAcc_src_t Is the tile type for src data of matC.
/// @tparam matB_t Is the tile type for matB.
/// @tparam matA_t Is the tile type for matA.
/// @tparam engine Is the compute engine, fpu or xmx.
/// @tparam arch_tag Is the hardware architecture tag.
template <typename matAcc_dst_t, typename matAcc_src_t, typename matB_t,
        typename matA_t, mma_engine engine, gpu_arch arch_tag,
        typename enable = void, typename custom_mma_attr = void>
struct tile_mma_t {};

/// @brief Is to illustrate the memory information
/// @tparam  mem_desc Is the memory descriptor
/// @tparam  tile_desc Is the tile descriptor
/// @tparam  message_type Is the form will be used to load/store
template <typename mem_desc, typename tile_desc, msg_type message_type,
        gpu_arch arch_tag, typename enable = void>
struct mem_payload_t {};

/// @brief Is to illustrate the memory information to prefetch data to cache.
/// @tparam mem_desc Is the memory descriptor
/// @tparam tile_desc_ Is the tile descriptor.
/// @tparam cooperative_num_ Is the thread nums to prefetch data.
/// @tparam arch_tag Is the hardware architecture tag.
template <typename mem_desc_, typename tile_desc_, uint32_t cooperative_num_,
        gpu_arch arch_tag, typename enable = void>
struct prefetch_payload_t {};

/// @brief Is to illustrate the tile information about a sub matrix.
/// @tparam tile_size_x_ Is the horizon tile size.
/// @tparam tile_size_y_ Is the vertical tile size.
/// @tparam block_size_x_ Is the horizon block size.
/// @tparam block_size_y_ Is the vertical block size.
/// @tparam reg_layout_ Is the register layout i.e. tiled, vnni_tiled and so on.
/// @tparam gpu_arch_ Is the hardware architecture tag.
template <uint32_t tile_size_x_, uint32_t tile_size_y_, uint32_t block_size_x_,
        uint32_t block_size_y_, reg_layout reg_layout_ = reg_layout::tiled>
struct tile_desc_t {
    static constexpr uint32_t tile_size_x = tile_size_x_;
    static constexpr uint32_t tile_size_y = tile_size_y_;

    static constexpr uint32_t block_size_x = block_size_x_;
    static constexpr uint32_t block_size_y = block_size_y_;
    static constexpr uint32_t remained_size_y = tile_size_y % block_size_y;

    static constexpr reg_layout register_layout = reg_layout_;
    static constexpr bool reg_transpose
            = reg_layout_ == reg_layout::transpose_tiled;

    static_assert(
            tile_size_x >= block_size_x, "tile_size_x should >= block_size_x ");
    static_assert(
            tile_size_y >= block_size_y, "tile_size_y should >= block_size_y ");
    static_assert(
            (tile_size_y == 1) || ((block_size_x & (block_size_x - 1)) == 0),
            "if tile_size_y > 1, block_size_x should be power of 2 ");
    static_assert(tile_size_x % (block_size_x) == 0,
            "Tile_size_x should be a multiple of block_size_x ");

    static constexpr uint32_t num_block_x = tile_size_x / block_size_x;
    static constexpr uint32_t num_block_y = tile_size_y / block_size_y;
    static constexpr uint32_t num_block
            = num_block_x * (num_block_y + (remained_size_y > 0 ? 1 : 0));

    static constexpr uint32_t block_elems = block_size_x * block_size_y;
    static constexpr uint32_t tile_elems = tile_size_x * tile_size_y;
};

/// @brief Is a struct contains some register file.
/// @tparam dtype_ Is the data type.
/// @tparam tile_desc_ Is tile_desc_t struct.
template <typename dtype_, typename tile_desc_>
struct tile_t : public tile_desc_ {
    using dtype = dtype_;
    using tile_desc = tile_desc_;
    xetla_vector<dtype, tile_desc::tile_elems> reg;

    // Cannot init value by constructor
    inline tile_t(native_type_t<dtype> val) {
        static_assert(!is_internal_type<dtype>::value,
                "compiler currently does NOT support using plained BF16 data "
                "to initialize a BF16 data");
        this->reg = val;
    }

    inline tile_t() = default;
    __XETLA_API void init(native_type_t<dtype> val) { this->reg = val; }
};

// Elementwise scale output: convert int32 accumulator to float using per-row/per-col scales
template <typename T_dst, typename T_src>
__XETLA_API typename std::enable_if_t<std::is_same<std::remove_cv_t<typename T_dst::dtype>, float>::value && std::is_same<std::remove_cv_t<typename T_src::dtype>, int32_t>::value, void> elemwise_scale_output(
        T_dst &dst, T_src &src, float scale_A, float scale_B) {
    constexpr uint32_t elems = T_src::tile_elems;
    using interm_t = float;
    auto intermediate = xetla_cvt<interm_t, typename T_src::dtype, elems>(src.reg);
#pragma unroll
    for (int i = 0; i < static_cast<int>(elems); ++i) {
        intermediate[i] = intermediate[i] * scale_A * scale_B;
    }
    dst.reg += xetla_cvt<typename T_dst::dtype, interm_t, elems>(intermediate);
}

// Overload: scaleA is a tile of per-row scales and scaleB is a tile of per-column scales.
// Accepts scaleA / scaleB tile dtypes of float OR fp16 (computation is promoted to float).
template <typename T_dst, typename T_src, typename T_scaleA, typename T_scaleB>
__XETLA_API typename std::enable_if_t<(std::is_same_v<std::remove_cv_t<typename T_dst::dtype>, float> || std::is_same_v<std::remove_cv_t<typename T_dst::dtype>, bf16> || std::is_same_v<std::remove_cv_t<typename T_dst::dtype>, fp16>) && std::is_same<std::remove_cv_t<typename T_src::dtype>, int32_t>::value
                && (std::is_same_v<std::remove_cv_t<typename T_scaleA::dtype>, float> || std::is_same_v<std::remove_cv_t<typename T_scaleA::dtype>, fp16>)
                && (std::is_same_v<std::remove_cv_t<typename T_scaleB::dtype>, float> || std::is_same_v<std::remove_cv_t<typename T_scaleB::dtype>, fp16>),
        void>
elemwise_scale_output(T_dst &dst, T_src &src, const T_scaleA &scaleA, const T_scaleB &scaleB) {
    using interm_t = float;
    using scaleB_dtype = std::remove_cv_t<typename T_scaleB::dtype>;
    constexpr uint32_t elems = T_src::tile_desc::tile_elems;
    constexpr uint32_t block_size_x = T_dst::tile_desc::block_size_x;
    constexpr uint32_t block_size_y = T_dst::tile_desc::block_size_y;
    constexpr uint32_t block_elems = T_dst::tile_desc::block_elems;
    constexpr uint32_t num_block_x = T_dst::tile_desc::num_block_x;
    constexpr uint32_t num_block_y = T_dst::tile_desc::num_block_y;
    constexpr int simd = (block_size_x > 16) ? 16 : block_size_x;
    auto scaleB_reg = scaleB.reg;
    auto intermediate = xetla_cvt<interm_t, typename T_src::dtype, elems>(src.reg);
#pragma unroll
    for (int i = 0; i < num_block_y; ++i) {
#pragma unroll
        for (int j = 0; j < num_block_x; ++j) {
#pragma unroll
            for (int ii = 0; ii < block_size_y; ++ii) {
                auto scaleA_val = static_cast<interm_t>(1.0f/static_cast<interm_t>(scaleA.reg[i * block_size_y + ii]));
                auto scaleA_vec = xetla_vector<interm_t, simd>(scaleA_val);
#pragma unroll
                for (int jj = 0; jj < block_size_x; jj += simd) {
                    if constexpr (std::is_same_v<scaleB_dtype, float>) {
                        auto scaleB_vec = scaleB_reg.xetla_select<simd, 1>(j * block_size_x + jj).xetla_format<interm_t>();
                        intermediate.xetla_select<simd, 1>((i * num_block_x + j) * block_elems + ii * block_size_x + jj) *= scaleB_vec * scaleA_vec;
                    } else {
                        // fp16 scales: convert to float before multiplying.
                        xetla_vector<scaleB_dtype, simd> scaleB_raw = scaleB_reg.xetla_select<simd, 1>(j * block_size_x + jj);
                        xetla_vector<interm_t, simd> scaleB_vec = xetla_cvt<interm_t, scaleB_dtype, simd>(scaleB_raw);
                        intermediate.xetla_select<simd, 1>((i * num_block_x + j) * block_elems + ii * block_size_x + jj) *= scaleB_vec * scaleA_vec;
                    }
                }
            }
        }
    }
    dst.reg += xetla_cvt<typename T_dst::dtype, interm_t, elems>(intermediate);
}

// Convert bf16 tile to int8 tile using per-row reciprocal scales
template <typename T_dst, typename T_src, typename T_scaleA>
__XETLA_API typename std::enable_if_t<
        std::is_same<std::remove_cv_t<typename T_src::dtype>, bf16>::value &&
        std::is_same<std::remove_cv_t<typename T_dst::dtype>, int8_t>::value &&
        std::is_same<std::remove_cv_t<typename T_scaleA::dtype>, float>::value,
        void>
elemwise_scale_bf16_to_int8(T_dst &dst, const T_src &src, const T_scaleA &scaleA) {
    using interm_t = float;
    constexpr uint32_t block_size_x = T_src::block_size_x;
    constexpr uint32_t block_size_y = T_src::block_size_y;
    constexpr uint32_t block_elems = T_src::block_elems;
    constexpr uint32_t num_block_x = T_src::num_block_x;
    constexpr uint32_t num_block_y = T_src::num_block_y;
#pragma unroll
    for (int ib = 0; ib < static_cast<int>(num_block_y); ++ib) {
#pragma unroll
        for (int jb = 0; jb < static_cast<int>(num_block_x); ++jb) {
#pragma unroll
            for (int ii = 0; ii < static_cast<int>(block_size_y); ++ii) {
                const uint32_t row = ib * block_size_y + ii;
                interm_t s_val = static_cast<interm_t>(scaleA.reg[row]);
                auto s_vec = xetla_vector<interm_t, block_size_x>(s_val);
                const uint32_t idx = (ib * num_block_x + jb) * block_elems + ii * block_size_x;
                auto src_reg = src.reg;
                dst.reg.xetla_select<block_size_x, 1>(idx) = xetla_sat<typename T_dst::dtype, interm_t, block_size_x>(src_reg.xetla_select<block_size_x, 1>(idx) * s_vec);
            }
        }
    }
}

// Convert fp16 tile to int8 tile using per-row reciprocal scales.
// Accepts scaleA tile dtype of float OR fp16 (computation is promoted to float).
template <typename T_dst, typename T_src, typename T_scaleA>
__XETLA_API typename std::enable_if_t<
        std::is_same<std::remove_cv_t<typename T_src::dtype>, fp16>::value &&
        std::is_same<std::remove_cv_t<typename T_dst::dtype>, int8_t>::value &&
        (std::is_same_v<std::remove_cv_t<typename T_scaleA::dtype>, float> || std::is_same_v<std::remove_cv_t<typename T_scaleA::dtype>, fp16>),
        void>
elemwise_scale_fp16_to_int8(T_dst &dst, const T_src &src, const T_scaleA &scaleA) {
    using interm_t = float;
    constexpr uint32_t block_size_x = T_src::block_size_x;
    constexpr uint32_t block_size_y = T_src::block_size_y;
    constexpr uint32_t block_elems = T_src::block_elems;
    constexpr uint32_t num_block_x = T_src::num_block_x;
    constexpr uint32_t num_block_y = T_src::num_block_y;
#pragma unroll
    for (int ib = 0; ib < static_cast<int>(num_block_y); ++ib) {
#pragma unroll
        for (int jb = 0; jb < static_cast<int>(num_block_x); ++jb) {
#pragma unroll
            for (int ii = 0; ii < static_cast<int>(block_size_y); ++ii) {
                const uint32_t row = ib * block_size_y + ii;
                interm_t s_val = static_cast<interm_t>(scaleA.reg[row]);
                auto s_vec = xetla_vector<interm_t, block_size_x>(s_val);
                const uint32_t idx = (ib * num_block_x + jb) * block_elems + ii * block_size_x;
                auto src_reg = src.reg;
                dst.reg.xetla_select<block_size_x, 1>(idx) = xetla_sat<typename T_dst::dtype, interm_t, block_size_x>(xetla_cvt<interm_t, fp16, block_size_x>(src_reg.xetla_select<block_size_x, 1>(idx)) * s_vec);
            }
        }
    }
}

} // namespace gpu::xetla::subgroup
