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

#pragma once

#include <algorithm>
#include <cfloat>
#include "subgroup/subgroup.hpp"
#include "xetla.hpp"

using namespace gpu::xetla;
using namespace gpu::xetla::subgroup;

template <typename dtype, int swidth, int sheight, int spitch, int twidth, int theight, int bwidth, int bheight, bool transform = false, bool transpose = false>
struct tile_row_reduction_func {
    static KERNEL_FUNC inline void run(sycl::nd_item<1> *item, dtype *a, dtype *b, dtype *c) {
        using matA_tile_desc_t = tile_desc_t<twidth, theight, bwidth, bheight, reg_layout::tiled>;
        using matC_tile_desc_t = tile_desc_t<twidth, 1, bwidth, 1, reg_layout::tiled>;
        using matA_t = tile_t<dtype, matA_tile_desc_t>;
        using matC_t = tile_t<dtype, matC_tile_desc_t>;
        using matA_payload_t = mem_payload_t<mem_desc_t<dtype, mem_layout::row_major, mem_space::global>, matA_tile_desc_t, msg_type_v<matA_tile_desc_t, mem_space::global>, gpu_arch::Xe>;
        using matC_payload_t = mem_payload_t<mem_desc_t<dtype, mem_layout::row_major, mem_space::global>, matC_tile_desc_t, msg_type_v<matC_tile_desc_t, mem_space::global>, gpu_arch::Xe>;
        matA_t matA;
        matC_t matC;
        matA_payload_t matA_payload(a, swidth, sheight, spitch, 0, 0);
        matC_payload_t matC_payload(c, swidth, sheight, spitch, 0, 0);
        matC.init(0);
        subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matA, matA_payload);
        matC.reg = subgroup::tile_reduce<reduce_op::sum, dtype, dtype, 0>(matA);
        tile_store(matC, matC_payload);
    }
};

template <typename in_dtype, int twidth, int theight, int bwidth, int bheight>
struct absmax_row_reduction {
    static KERNEL_FUNC inline void run(sycl::nd_item<1> it, in_dtype *a_base, int swidth, int sheight, int spitch, int scale_bs, float *c_base) {
        const int group_id = static_cast<int>(it.get_group(0));
        const int local_id = static_cast<int>(it.get_local_id(0));
        const int total_rows = sheight;
        const int total_cols = swidth;
        const int tiles_per_row = ((total_cols + twidth - 1) / twidth) / scale_bs;
        // Each work-item in the group processes one row within the group block.
        const int group_base = group_id * theight;
        const int row = group_base + local_id;
        if (row >= total_rows) return;

        // Use a per-thread tile of height=1 so threads do not overlap rows.
        using row_tile_desc_t = tile_desc_t<twidth, 1, twidth, 1, reg_layout::tiled>;
        using row_tile_t = tile_t<in_dtype, row_tile_desc_t>;
        using row_payload_t = mem_payload_t<mem_desc_t<in_dtype, mem_layout::row_major, mem_space::global>, row_tile_desc_t, msg_type_v<row_tile_desc_t, mem_space::global>, gpu_arch::Xe>;
        using row_prefetch_payload_t = subgroup::prefetch_payload_t<mem_desc_t<in_dtype, mem_layout::row_major, mem_space::global>, row_tile_desc_t, twidth, gpu_arch::Xe>;

        row_tile_t row_tile;
        row_payload_t row_payload(a_base + row * spitch, swidth, 1, spitch, 0, 0);
        row_prefetch_payload_t row_payload_prefetch(a_base + row * spitch, swidth, 1, spitch, 0, 0);

        // accumulator for this thread's row
        xetla_vector<float, twidth> src_reg_f32;
        xetla_mask<row_tile_t::tile_size_x> mask_max;

        for (int igs = 0; igs < scale_bs; igs++) {
            xetla_vector<float, twidth> acc_vec = FLT_EPSILON;
#pragma unroll
            for (int t = 0; t < tiles_per_row; ++t) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(row_payload_prefetch);
                row_payload_prefetch.template update_tdesc<tdesc_update_dir::x_dir>(row_tile_t::tile_size_x);
            }

#pragma unroll
            for (int t = 0; t < tiles_per_row; ++t) {
                subgroup::tile_load<cache_hint::cached, cache_hint::cached>(row_tile, row_payload);
                // advance by this row-tile width
                row_payload.template update_tdesc<tdesc_update_dir::x_dir>(row_tile_t::tile_size_x);
                // convert to float (per-lane) and take absolute value correctly
                src_reg_f32 = xetla_abs<float, row_tile_t::tile_size_x>(xetla_cvt<float, in_dtype, row_tile_t::tile_size_x>(row_tile.reg.xetla_select<row_tile_t::tile_size_x, 1>(0)));
                mask_max = src_reg_f32 > acc_vec;
                acc_vec.xetla_merge(src_reg_f32, acc_vec, mask_max);
            }

            // compute final row max
            float row_max = xetla_reduce<float, float, twidth, reduce_op::max>(acc_vec);
            c_base[igs * sheight + row] = static_cast<float>(127.0 / row_max);
        }
    }
};
