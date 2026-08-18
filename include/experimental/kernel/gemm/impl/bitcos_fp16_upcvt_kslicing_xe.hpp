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
///
/// Kernel-level (workgroup) orchestrator for int1 weight-only GEMM with fp16
/// activations and per-K-group fp16 scale (no zero-point). Adapted from
/// `int2_fp16_upcvt_kslicing_xe.hpp`.
///
/// matB packing convention for THIS variant:
///   B is stored as int1x32 (uint32_t) packed along the K axis.
///   In memory shape (K/pack_ratio rows) x (matrix_n cols).

#pragma once

#include "experimental/kernel/gemm/common.hpp"
#include "experimental/kernel/gemm/dispatch_policy.hpp"

namespace gpu::xetla::kernel {

/// @addtogroup xetla_gemm
/// @{

template <int num_global_kslicing_, int num_local_kslicing_, typename gemm_t_,
        typename epilogue_t_, typename group_swizzle_>
class gemm_universal_t<dispatch_policy_bitcos_fp16_upcvt_kslicing<group_swizzle_,
                               num_global_kslicing_, num_local_kslicing_>,
        gemm_t_, epilogue_t_> {
    using gemm_t = gemm_t_;
    using epilogue_t = epilogue_t_;
    using gemm_args_t = typename gemm_t::arguments_t;
    using epilogue_args_t = typename epilogue_t::arguments_t;
    using tile_shape = typename gemm_t::tile_shape;
    using group_swizzle_t = group_swizzle_;
    static constexpr uint32_t wg_tile_m = tile_shape::wg_tile_size_y;
    static constexpr uint32_t wg_tile_n = tile_shape::wg_tile_size_x;
    static constexpr uint32_t sg_tile_m = tile_shape::sg_tile_size_y;
    static constexpr uint32_t sg_tile_n = tile_shape::sg_tile_size_x;
    static constexpr uint32_t wg_size_y = tile_shape::wg_size_y;
    static constexpr uint32_t wg_size_x = tile_shape::wg_size_x;
    static constexpr uint32_t real_wg_tile_m = sg_tile_m * wg_size_y;
    static constexpr uint32_t real_wg_tile_n = sg_tile_n * wg_size_x;

    static constexpr uint32_t k_stride = gemm_t::k_stride;
    static constexpr uint32_t dequant_s = gemm_t::dequant_s;
    static constexpr uint32_t pack_ratio = gemm_t::pack_ratio;
    using work_group_t = typename gemm_t::work_group_t;
    static constexpr uint32_t work_group_size = work_group_t::size;

    static constexpr gpu_arch arch_tag = gpu_arch::Xe;
    static_assert(arch_tag == gemm_t::arch_tag, "arch_tag should be the same");
    static_assert(
            arch_tag == epilogue_t::arch_tag, "arch_tag should be the same");
    static_assert(std::is_same<typename gemm_t::tile_shape,
                          typename epilogue_t::tile_shape>::value,
            "tile_shape should be the same");

    using mem_desc_a_t = typename gemm_t::mem_desc_a_t;
    using mem_desc_b_t = typename gemm_t::mem_desc_b_t;
    using mem_desc_scale_t = typename gemm_t::mem_desc_scale_t;
    using mem_desc_c_t = typename epilogue_t::mem_desc_c_t;
    using matA_base_t = typename mem_desc_a_t::base_t;
    using matB_base_t = typename mem_desc_b_t::base_t;
    using matC_base_t = typename mem_desc_c_t::base_t;
    using scale_base_t = typename mem_desc_scale_t::base_t;

    using dtype_a = typename mem_desc_a_t::dtype;
    using dtype_b = typename mem_desc_b_t::dtype;
    using dtype_c = typename mem_desc_c_t::dtype;
    using dtype_scale = typename mem_desc_scale_t::dtype;
    using matAcc_t = typename gemm_t::matAcc_t;
    using dtype_acc = typename matAcc_t::dtype;
    using mem_desc_acc_t
            = mem_desc_t<dtype_acc, mem_layout::row_major, mem_space::global>;
    using mem_desc_cnt_t
            = mem_desc_t<uint32_t, mem_layout::row_major, mem_space::global>;
    using acc_base_t = typename mem_desc_acc_t::base_t;
    using cnt_base_t = typename mem_desc_cnt_t::base_t;

    static_assert(gemm_t::compute_policy::is_int1_matB_policy,
            "should match with int1 gemm impl");

    static constexpr uint32_t num_global_kslicing = num_global_kslicing_;
    static constexpr uint32_t num_local_kslicing = num_local_kslicing_;
    static_assert((num_global_kslicing > 0) && (num_local_kslicing > 0),
            "min slicing ratio is 1");
    static_assert((num_local_kslicing & (num_local_kslicing - 1)) == 0,
            "num_local_kslicing should be power of 2!");
    static_assert(num_global_kslicing == 1,
            "BITCOS global K slicing needs globally indexed rank metadata");

    using kslicing_t = group::cooperative_reduce_t<reduce_op::sum, tile_shape,
            matAcc_t, num_local_kslicing, gpu_arch::Xe>;
    using mat_slice_t = typename kslicing_t::mat_slice_t;
    static constexpr uint32_t ks_coop_num_x = kslicing_t::coop_num_x;
    static constexpr uint32_t ks_coop_num_y = kslicing_t::coop_num_y;

    static constexpr uint32_t gemm_nbarr_count = gemm_t::barrier_count;
    static constexpr uint32_t gemm_slm_size = gemm_t::slm_size;

    static constexpr uint32_t epilogue_nbarr_count = epilogue_t::barrier_count;
    static constexpr uint32_t epilogue_slm_size = epilogue_t::slm_size;

    static constexpr uint32_t kslicing_nbarr_count = kslicing_t::barrier_count;
    static constexpr uint32_t kslicing_slm_size = kslicing_t::slm_size;

    static constexpr uint32_t counter_size = 8;

    using tile_shape_cnt = group::tile_shape_t<ks_coop_num_x * wg_size_x,
            ks_coop_num_y * wg_size_y, ks_coop_num_x, ks_coop_num_y>;

    using global_group_reduce_t = group::global_reduce_t<reduce_op::sum,
            tile_shape, tile_shape_cnt, mem_desc_acc_t, mem_desc_cnt_t,
            num_global_kslicing, counter_size, gpu_arch::Xe>;

public:
    /// @brief GEMM arguments.
    struct arguments_t {
        uint32_t matrix_m;
        uint32_t matrix_k;
        uint32_t matrix_n;
        uint32_t matA_ld;
        uint32_t matB_ld; // pitch in fp16-equivalent N elements
        uint32_t matC_ld;
        matA_base_t matA_base;
        matB_base_t matB_base;
        matC_base_t matC_base;
        acc_base_t acc_base;
        cnt_base_t cnt_base;
        epilogue_args_t epilogue_args;

        scale_base_t scale_base;
        uint32_t scale_ld;
        // planes 2 and 3 of the BITCOS buffer; derived by the caller from (K, N)
        uint32_t *signs_base;
        uint32_t *offsets_base;
        uint32_t *slice_ranks_base;

        inline arguments_t() = default;
        static constexpr bool host_callable = true;

        inline arguments_t(uint32_t matrix_m_, uint32_t matrix_k_,
                uint32_t matrix_n_, matA_base_t matA_base_, uint32_t matA_ld_,
                matB_base_t matB_base_, uint32_t matB_ld_,
                matC_base_t matC_base_, uint32_t matC_ld_,
                scale_base_t scale_base_, uint32_t scale_ld_,
                uint32_t *signs_base_ = nullptr,
                uint32_t *offsets_base_ = nullptr,
                uint32_t *slice_ranks_base_ = nullptr,
                acc_base_t acc_base_ = {}, cnt_base_t cnt_base_ = {},
                epilogue_args_t epilogue_args_ = {})
            : matrix_m(matrix_m_)
            , matrix_k(matrix_k_)
            , matrix_n(matrix_n_)
            , matA_ld(matA_ld_)
            , matB_ld(matB_ld_)
            , matC_ld(matC_ld_)
            , matA_base(matA_base_)
            , matB_base(matB_base_)
            , matC_base(matC_base_)
            , acc_base(acc_base_)
            , cnt_base(cnt_base_)
            , epilogue_args(epilogue_args_)
            , scale_base(scale_base_)
            , scale_ld(scale_ld_)
            , signs_base(signs_base_)
            , offsets_base(offsets_base_)
            , slice_ranks_base(slice_ranks_base_) {}

        inline arguments_t(const arguments_t &args)
            : matrix_m(args.matrix_m)
            , matrix_k(args.matrix_k)
            , matrix_n(args.matrix_n)
            , matA_ld(args.matA_ld)
            , matB_ld(args.matB_ld)
            , matC_ld(args.matC_ld)
            , matA_base(args.matA_base)
            , matB_base(args.matB_base)
            , matC_base(args.matC_base)
            , acc_base(args.acc_base)
            , cnt_base(args.cnt_base)
            , epilogue_args(args.epilogue_args)
            , scale_base(args.scale_base)
            , scale_ld(args.scale_ld)
            , signs_base(args.signs_base)
            , offsets_base(args.offsets_base)
            , slice_ranks_base(args.slice_ranks_base) {}

        inline arguments_t &operator=(const arguments_t &args) {
            this->matrix_m = args.matrix_m;
            this->matrix_k = args.matrix_k;
            this->matrix_n = args.matrix_n;
            this->matA_base = args.matA_base;
            this->matA_ld = args.matA_ld;
            this->matB_base = args.matB_base;
            this->matB_ld = args.matB_ld;
            this->matC_base = args.matC_base;
            this->matC_ld = args.matC_ld;
            this->scale_base = args.scale_base;
            this->scale_ld = args.scale_ld;
            this->signs_base = args.signs_base;
            this->offsets_base = args.offsets_base;
            this->slice_ranks_base = args.slice_ranks_base;
            this->acc_base = args.acc_base;
            this->cnt_base = args.cnt_base;
            this->epilogue_args = args.epilogue_args;
            return *this;
        }
    };

    __XETLA_API static constexpr uint32_t get_barrier_count() {
        constexpr uint32_t count = gemm_nbarr_count * num_local_kslicing
                + kslicing_nbarr_count
                + epilogue_nbarr_count * num_local_kslicing;
        static_assert(
                count <= 32, "The named_barrier count should be less than 32!");
        return count;
    }

    __XETLA_API static constexpr uint32_t get_slm_size() {
        constexpr uint32_t gemm_slm_partitions
                = gemm_t::share_slm_across_kslices ? 1 : num_local_kslicing;
        constexpr uint32_t size = gemm_slm_size * gemm_slm_partitions
                + kslicing_slm_size + epilogue_slm_size * num_local_kslicing;
        static_assert(size <= (128 * 1024),
                "The local memory size should be less than 128KB!");
        return size;
    }

    static cl::sycl::range<3> get_local_range() {
        uint32_t local_range_m = (wg_tile_m + sg_tile_m - 1) / sg_tile_m;
        uint32_t local_range_n = (wg_tile_n + sg_tile_n - 1) / sg_tile_n;
#ifdef DEBUG
        std::cout << "Local range: {" << num_local_kslicing << ", "
                  << local_range_m << ", " << local_range_n << "} \n";
#endif
        assert(local_range_m * local_range_n * num_local_kslicing <= 32);
        return cl::sycl::range<3> {
                num_local_kslicing, local_range_m, local_range_n};
    };

    static cl::sycl::range<3> get_group_range(
            uint32_t matrix_m, uint32_t matrix_n) {
        uint32_t group_range_m = (matrix_m + wg_tile_m - 1) / wg_tile_m;
        uint32_t group_range_n = (matrix_n + wg_tile_n - 1) / wg_tile_n;
        group_swizzle_t::update_group_range(group_range_m, group_range_n);
#ifdef DEBUG
        std::cout << "Group range: {" << num_global_kslicing << ", "
                  << group_range_m << ", " << group_range_n << "} \n";
#endif
        return cl::sycl::range<3> {
                num_global_kslicing, group_range_m, group_range_n};
    };

    static cl::sycl::nd_range<3> get_nd_range(arguments_t &args) {
        cl::sycl::range<3> local_range = get_local_range();
        cl::sycl::range<3> group_range
                = get_group_range(args.matrix_m, args.matrix_n);
        return cl::sycl::nd_range<3> {group_range * local_range, local_range};
    };

    static size_t get_acc_buf_size(uint32_t matrix_m, uint32_t matrix_n) {
        return matrix_m * matrix_n;
    };

    static size_t get_cnt_buf_size(uint32_t matrix_m, uint32_t matrix_n) {
        size_t group_range_m = (matrix_m + wg_tile_m - 1) / wg_tile_m;
        size_t group_range_n = (matrix_n + wg_tile_n - 1) / wg_tile_n;
        return group_range_m * group_range_n * wg_size_y * wg_size_x
                * ks_coop_num_y * ks_coop_num_x * counter_size;
    };

    static bool can_implement(arguments_t &args) {
        bool implementable = true;
        if (gemm_t::msg_type_a != msg_type::unaligned_2d) {
            if (gemm_t::msg_type_a == msg_type::block_2d) {
                implementable &= kernel::block_2d<gpu_arch::Xe,
                        dtype_a>::check_tensor((uint64_t)(args.matA_base.base),
                        gemm_t::is_col_major_a ? args.matrix_m : args.matrix_k,
                        gemm_t::is_col_major_a ? args.matrix_k : args.matrix_m,
                        args.matA_ld);
            } else {
                implementable &= kernel::general_1d<gpu_arch::Xe,
                        dtype_a>::check_alignment(args.matA_base.base,
                        args.matA_ld);
            }
        }
        // matB packed along K: leading dim is matrix_n (in fp16-equiv cols);
        // tensor row count is matrix_k / pack_ratio.
        if (gemm_t::msg_type_b != msg_type::unaligned_2d) {
            if (gemm_t::msg_type_b == msg_type::block_2d) {
                implementable &= kernel::block_2d<gpu_arch::Xe,
                        dtype_b>::check_tensor((uint64_t)(args.matB_base.base),
                        args.matrix_n, args.matrix_k / pack_ratio,
                        args.matB_ld);
            } else {
                implementable &= kernel::general_1d<gpu_arch::Xe,
                        dtype_b>::check_alignment(
                        args.matB_base.base, args.matB_ld);
            }
        }
        if (epilogue_t::msg_type_c != msg_type::unaligned_2d) {
            if (epilogue_t::msg_type_c == msg_type::block_2d) {
                implementable &= kernel::block_2d<gpu_arch::Xe,
                        dtype_c>::check_tensor((uint64_t)(args.matC_base.base),
                        args.matrix_n, args.matrix_m, args.matC_ld);
            } else {
                implementable &= kernel::general_1d<gpu_arch::Xe,
                        dtype_c>::check_alignment(args.matC_base.base,
                        args.matC_ld);
            }
        }
        // K must be a multiple of pack_ratio (32) for clean packing.
        implementable &= ((args.matrix_k % pack_ratio == 0));

        return implementable;
    }

    /// @brief Main execution function for GEMM.
    __XETLA_API KERNEL_FUNC void operator()(sycl::nd_item<3> &item,
            const arguments_t &args, uint32_t slm_base = 0,
            uint32_t nbarrier_base = 0) {
        work_group_t g(item.get_local_linear_id() % work_group_size);
        uint32_t wg_id = item.get_local_linear_id() / work_group_size;
        group_swizzle_t group_swizzle;
        int start_m = group_swizzle.template get_tile_idx<1>(item) * wg_tile_m;
        int start_n = group_swizzle.template get_tile_idx<2>(item) * wg_tile_n;
        int start_k = 0;
        uint32_t wg_tile_k = args.matrix_k;
        uint32_t boundary_n = (start_n + wg_tile_n) > args.matrix_n
                ? args.matrix_n
                : (start_n + wg_tile_n);
        uint32_t boundary_m = (start_m + wg_tile_m) > args.matrix_m
                ? args.matrix_m
                : (start_m + wg_tile_m);
        uint32_t boundary_k = wg_tile_k;
        if constexpr (num_global_kslicing > 1) {
            wg_tile_k = (wg_tile_k + num_global_kslicing - 1)
                    / num_global_kslicing;
            start_k = start_k
                    + group_swizzle.template get_tile_idx<0>(item) * wg_tile_k;
            boundary_k = (start_k + wg_tile_k) > boundary_k
                    ? boundary_k
                    : (start_k + wg_tile_k);
        }
        if constexpr (num_local_kslicing > 1) {
            wg_tile_k
                    = (wg_tile_k + num_local_kslicing - 1) / num_local_kslicing;
            start_k = start_k + wg_id * wg_tile_k;
            boundary_k = (start_k + wg_tile_k) > boundary_k
                    ? boundary_k
                    : (start_k + wg_tile_k);
        }

        int start_x_scale = start_n;
        int start_y_scale = start_k / dequant_s;

        uint32_t gemm_slm_base = slm_base;
        uint32_t gemm_nbarr_base = nbarrier_base;
        if constexpr (num_local_kslicing > 1) {
            if constexpr (!gemm_t::share_slm_across_kslices)
                gemm_slm_base = slm_base + wg_id * gemm_slm_size;
            gemm_nbarr_base = nbarrier_base + wg_id * gemm_nbarr_count;
        }
        constexpr uint32_t gemm_slm_partitions
                = gemm_t::share_slm_across_kslices ? 1 : num_local_kslicing;
        uint32_t kslicing_slm_base
                = slm_base + gemm_slm_partitions * gemm_slm_size;
        uint32_t kslicing_nbarr_base
                = nbarrier_base + num_local_kslicing * gemm_nbarr_count;
        uint32_t epilogue_slm_base = kslicing_slm_base + kslicing_slm_size;
        uint32_t epilogue_nbarr_base
                = kslicing_nbarr_base + kslicing_nbarr_count;

        mem_desc_a_t mem_desc_a;
        mem_desc_b_t mem_desc_b;
        mem_desc_c_t mem_desc_c;

        mem_desc_a.init(args.matA_base, {boundary_k, boundary_m, args.matA_ld},
                {start_k, start_m});
        // matB packed along K: shape (boundary_n cols, boundary_k/pack_ratio
        // rows), pitch = matB_ld in fp16-equivalent N elements.
        mem_desc_b.init(args.matB_base,
                {boundary_n, boundary_k / pack_ratio, args.matB_ld},
                {start_n, static_cast<int>(start_k / pack_ratio)});

        uint32_t scale_size_y = ((args.matrix_k + dequant_s - 1) / dequant_s);
        mem_desc_scale_t mem_desc_scale(args.scale_base,
                {args.matrix_n, scale_size_y, args.scale_ld},
                {start_x_scale, start_y_scale});

        uint32_t inner_loop_count = (wg_tile_k + k_stride - 1) / k_stride;
        uint32_t *initial_ranks = nullptr;
        if constexpr (num_local_kslicing > 1) {
            if (wg_id > 0)
                initial_ranks = args.slice_ranks_base
                        + static_cast<size_t>(wg_id - 1) * args.matrix_n;
        }
        gemm_args_t gemm_args(mem_desc_a, mem_desc_b, inner_loop_count,
                mem_desc_scale, args.signs_base, args.offsets_base,
                initial_ranks);
        matAcc_t matAcc;
        matAcc.init(0);
        gemm_t gemm;
        gemm(g, matAcc, gemm_args, gemm_slm_base, gemm_nbarr_base);

        kslicing_t kslicing(wg_id);
        mat_slice_t mat_slice;
        kslicing(g, mat_slice, matAcc, kslicing_slm_base, kslicing_nbarr_base);

        if (kslicing.is_valid_post_process_wg()) {
            int32_t coop_offset_x
                    = kslicing.coop_id_x * mat_slice_t::tile_size_x;
            int32_t coop_offset_y
                    = kslicing.coop_id_y * mat_slice_t::tile_size_y;
            int32_t acc_start_x = start_n + coop_offset_x;
            int32_t acc_start_y = start_m + coop_offset_y;
            int32_t cnt_start_x = group_swizzle.template get_tile_idx<2>(item)
                            * tile_shape_cnt::wg_tile_size_x
                    + kslicing.coop_id_x;
            int32_t cnt_start_y = group_swizzle.template get_tile_idx<1>(item)
                            * tile_shape_cnt::wg_tile_size_y
                    + kslicing.coop_id_y;
            uint32_t group_range_x = item.get_group_range(2);
            uint32_t group_range_y = item.get_group_range(1);
            uint32_t cnt_size_x
                    = group_range_x * tile_shape_cnt::wg_tile_size_x;
            uint32_t cnt_size_y
                    = group_range_y * tile_shape_cnt::wg_tile_size_y;
            mem_desc_acc_t mem_desc_acc(args.acc_base,
                    {boundary_n, boundary_m, args.matrix_n},
                    {acc_start_x, acc_start_y});
            mem_desc_cnt_t mem_desc_cnt(args.cnt_base,
                    {cnt_size_x, cnt_size_y, cnt_size_x},
                    {cnt_start_x, cnt_start_y});

            global_group_reduce_t global_group_reduce;
            global_group_reduce(g, mat_slice, mem_desc_acc, mem_desc_cnt);

            if (global_group_reduce.is_last_group()) {
                if constexpr (mem_desc_c_t::is_local) {
                    mem_desc_c.init(args.matC_base,
                            {real_wg_tile_n, real_wg_tile_m, real_wg_tile_n},
                            {coop_offset_x, coop_offset_y});
                } else {
                    mem_desc_c.init(args.matC_base,
                            {boundary_n, boundary_m, args.matC_ld},
                            {start_n + coop_offset_x, start_m + coop_offset_y});
                }
                epilogue_t epilogue;
                epilogue(g, mat_slice, mem_desc_c, args.epilogue_args,
                        epilogue_slm_base, epilogue_nbarr_base);
            }
        }
    }
};

/// @} xetla_gemm

} // namespace gpu::xetla::kernel
