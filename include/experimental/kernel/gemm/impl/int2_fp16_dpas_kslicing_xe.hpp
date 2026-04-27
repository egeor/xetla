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

#include <cfloat>  // For FLT_EPSILON

#ifdef _WIN32
#include "../../../../experimental/kernel/gemm/common.hpp"
#include "../../../../experimental/kernel/gemm/dispatch_policy.hpp"
#else
#include "experimental/kernel/gemm/common.hpp"
#include "experimental/kernel/gemm/dispatch_policy.hpp"
#endif

namespace gpu::xetla::kernel {

/// @addtogroup xetla_gemm
/// @{

/// @brief Is the GEMM functor, specialized in int2_fp16 matB kslicing dispatch policy and Xe architecture.
///
/// @tparam num_global_kslicing_ Is the k dim split ratio between groups.
/// @tparam num_local_kslicing_ Is the k dim split ratio within a group.
/// @tparam use_external_scale_a_ If true, scale A is computed externally in a separate kernel; if false, computed internally in SLM.
/// @tparam gemm_t_ Is the gemm functor to compose a GEMM.
/// @tparam epilogue_t_ Is the epilogue functor to compose a GEMM.
template <int num_global_kslicing_, int num_local_kslicing_, bool use_external_scale_a_, typename gemm_t_, typename epilogue_t_, typename group_swizzle_>
class gemm_universal_t<dispatch_policy_int2_fp16_dpas_kslicing<group_swizzle_, num_global_kslicing_, num_local_kslicing_, use_external_scale_a_>, gemm_t_, epilogue_t_,
        std::enable_if_t<(group_swizzle_::arch_tag == gpu_arch::Xe)
                >> {
    using gemm_t = gemm_t_;
    using epilogue_t = epilogue_t_;
    // Create gemm_args_t with appropriate scale_a memory descriptor type
    using gemm_args_t = typename gemm_t::template arguments_tmpl_t<
        std::conditional_t<use_external_scale_a_,
                          mem_desc_t<typename gemm_t::dtype_scale_a, mem_layout::row_major, mem_space::global>,
                          mem_desc_t<typename gemm_t::dtype_scale_a, mem_layout::row_major, mem_space::local>>,
        mem_desc_t<typename gemm_t::dtype_scale_b, mem_layout::row_major, mem_space::global>>;
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
    static constexpr uint32_t mma_xmx_m = gemm_t::mma_xmx_m;
    static constexpr uint32_t pack_ratio = gemm_t::pack_ratio;
    static constexpr uint32_t packed_row = gemm_t::packed_row;
    using work_group_t = typename gemm_t::work_group_t;
    static constexpr uint32_t work_group_size = work_group_t::size;

    static constexpr gpu_arch arch_tag = group_swizzle_t::arch_tag;
    static_assert(arch_tag == gemm_t::arch_tag, "arch_tag should be the same");
    static_assert(arch_tag == epilogue_t::arch_tag, "arch_tag should be the same");
    static_assert(std::is_same<typename gemm_t::tile_shape, typename epilogue_t::tile_shape>::value, "tile_shape should be the same");

    using mem_desc_a_t = typename gemm_t::mem_desc_a_t;
    using mem_desc_b_t = typename gemm_t::mem_desc_b_t;
    using mem_desc_c_t = typename epilogue_t::mem_desc_c_t;
    // Override mem_desc_scale_a_t based on use_external_scale_a_
    using mem_desc_scale_a_t = std::conditional_t<use_external_scale_a_,
                                                   mem_desc_t<typename gemm_t::dtype_scale_a, mem_layout::row_major, mem_space::global>,
                                                   mem_desc_t<typename gemm_t::dtype_scale_a, mem_layout::row_major, mem_space::local>>;
    using mem_desc_scale_b_t = typename gemm_t::mem_desc_scale_b_t;
    using matA_base_t = typename mem_desc_a_t::base_t;
    using matB_base_t = typename mem_desc_b_t::base_t;
    using matC_base_t = typename mem_desc_c_t::base_t;
    using scale_b_base_t = typename mem_desc_scale_b_t::base_t;

public:
    // Make scale_a_base_t public so it can be accessed from main.cpp
    using scale_a_base_t = typename mem_desc_scale_a_t::base_t;

private:

    using dtype_a = typename mem_desc_a_t::dtype;
    using dtype_b = typename mem_desc_b_t::dtype;
    using dtype_c = typename mem_desc_c_t::dtype;
    using dtype_scale_a = typename mem_desc_scale_a_t::dtype;
    using dtype_scale_b = typename mem_desc_scale_b_t::dtype;
    using matAcc_t = typename gemm_t::matAcc_t;
    using dtype_acc = typename matAcc_t::dtype;
    using mem_desc_acc_t = mem_desc_t<dtype_acc, mem_layout::row_major, mem_space::global>;
    using mem_desc_cnt_t = mem_desc_t<uint32_t, mem_layout::row_major, mem_space::global>;
    using acc_base_t = typename mem_desc_acc_t::base_t;
    using cnt_base_t = typename mem_desc_cnt_t::base_t;

    static_assert(gemm_t::compute_policy::is_int2_fp16_dpas_policy, "should match with 2bit fp16 gemm impl");

    static constexpr uint32_t num_global_kslicing = num_global_kslicing_;
    static constexpr uint32_t num_local_kslicing = num_local_kslicing_;
    static_assert((num_global_kslicing > 0) && (num_local_kslicing > 0), "min slicing ratio is 1");

    static_assert((num_local_kslicing & (num_local_kslicing - 1)) == 0, "num_local_kslicing should be power of 2!");

    using kslicing_t = group::cooperative_reduce_t<reduce_op::sum, tile_shape, matAcc_t, num_local_kslicing, arch_tag>;
    using mat_slice_t = typename kslicing_t::mat_slice_t;
    static constexpr uint32_t ks_coop_num_x = kslicing_t::coop_num_x;
    static constexpr uint32_t ks_coop_num_y = kslicing_t::coop_num_y;

    static constexpr uint32_t gemm_nbarr_count = gemm_t::barrier_count;
    static constexpr uint32_t gemm_slm_size = gemm_t::slm_size;

    static constexpr uint32_t epilogue_nbarr_count = epilogue_t::barrier_count;
    static constexpr uint32_t epilogue_slm_size = epilogue_t::slm_size;

    static constexpr uint32_t kslicing_nbarr_count = kslicing_t::barrier_count;
    static constexpr uint32_t kslicing_slm_size = kslicing_t::slm_size;

    static constexpr bool use_external_scale_a = use_external_scale_a_;
    
    // Scale A computation resources (only used when use_external_scale_a = false)
    static constexpr uint32_t scale_a_nbarr_count = use_external_scale_a ? 0 : 1;
    static constexpr uint32_t scale_a_slm_size = use_external_scale_a ? 0 : (wg_tile_m * sizeof(float) * 128);

    static constexpr uint32_t counter_size = 8;

    using tile_shape_cnt = group::tile_shape_t<ks_coop_num_x * wg_size_x, ks_coop_num_y * wg_size_y, ks_coop_num_x, ks_coop_num_y>;

    using global_group_reduce_t = group::global_reduce_t<reduce_op::sum, tile_shape, tile_shape_cnt, mem_desc_acc_t, mem_desc_cnt_t, num_global_kslicing, counter_size, arch_tag>;

public:
    /// @brief GEMM arguments.
    /// This is the interface for users to pass the application-related runtime variables.
    struct arguments_t {
        /// @brief Is the size of the m dimension of the matrix multiplication (m x k x n).
        uint32_t matrix_m;
        /// @brief Is the size of the k dimension of the matrix multiplication (m x k x n).
        uint32_t matrix_k;
        /// @brief Is the size of the n dimension of the matrix multiplication (m x k x n).
        uint32_t matrix_n;
        /// @brief Is the leading dimension (pitch) size of the matrix A in memory.
        uint32_t matA_ld;
        /// @brief Is the leading dimension (pitch) size of the matrix B in memory.
        uint32_t matB_ld;
        /// @brief Is the leading dimension (pitch) size of the matrix C in memory.
        uint32_t matC_ld;
        /// @brief Is the base address of matrix A.
        matA_base_t matA_base;
        /// @brief Is the base address of matrix B.
        matB_base_t matB_base;
        /// @brief Is the base address of matrix C.
        matC_base_t matC_base;
        /// @brief Is the base address of accumulation buffer.
        acc_base_t acc_base;
        /// @brief Is the base address of counter buffer.
        cnt_base_t cnt_base;
        /// @brief Is the epilogue arguments.
        epilogue_args_t epilogue_args;

        scale_a_base_t scale_a_base;
        uint32_t scale_a_ld;
        scale_b_base_t scale_b_base;
        uint32_t scale_b_ld;
        // runtime scale group size (no compile-time alias; default to 1)
        uint32_t scale_gs = 1;

        /// @brief Constructs arguments with default method.
        inline arguments_t() = default;

        /// @brief Set for device copyable
        static constexpr bool host_callable = true;

        // Be aware of the risks: Rule of three (copy constructor, copy assignment, destructor)
        // Please check if you need to add self-define destructor
        // ~arguments_t(){}

        /// @brief Constructs arguments with initialization list (no scales).
        inline arguments_t(uint32_t matrix_m_, uint32_t matrix_k_, uint32_t matrix_n_, matA_base_t matA_base_, uint32_t matA_ld_, matB_base_t matB_base_, uint32_t matB_ld_, matC_base_t matC_base_, uint32_t matC_ld_,
                acc_base_t acc_base_ = {}, cnt_base_t cnt_base_ = {}, epilogue_args_t epilogue_args_ = {})
            : matrix_m(matrix_m_)
            , matrix_k(matrix_k_)
            , matrix_n(matrix_n_)
            , matA_base(matA_base_)
            , matA_ld(matA_ld_)
            , matB_base(matB_base_)
            , matB_ld(matB_ld_)
            , matC_base(matC_base_)
            , matC_ld(matC_ld_)
            , scale_a_base({})
            , scale_a_ld(0)
            , scale_b_base({})
            , scale_b_ld(0)
            , scale_gs(1)
            , acc_base(acc_base_)
            , cnt_base(cnt_base_)
            , epilogue_args(epilogue_args_) {}

        /// @brief Constructs arguments with scale support (explicit scale_gs).
        inline arguments_t(uint32_t matrix_m_, uint32_t matrix_k_, uint32_t matrix_n_, matA_base_t matA_base_, uint32_t matA_ld_, matB_base_t matB_base_, uint32_t matB_ld_, matC_base_t matC_base_, uint32_t matC_ld_,
                scale_a_base_t scale_a_base_, uint32_t scale_a_ld_, scale_b_base_t scale_b_base_, uint32_t scale_b_ld_, uint32_t scale_gs_ = 1, acc_base_t acc_base_ = {}, cnt_base_t cnt_base_ = {}, epilogue_args_t epilogue_args_ = {})
            : matrix_m(matrix_m_)
            , matrix_k(matrix_k_)
            , matrix_n(matrix_n_)
            , matA_base(matA_base_)
            , matA_ld(matA_ld_)
            , matB_base(matB_base_)
            , matB_ld(matB_ld_)
            , matC_base(matC_base_)
            , matC_ld(matC_ld_)
            , scale_a_base(scale_a_base_)
            , scale_a_ld(scale_a_ld_)
            , scale_b_base(scale_b_base_)
            , scale_b_ld(scale_b_ld_)
            , scale_gs(scale_gs_)
            , acc_base(acc_base_)
            , cnt_base(cnt_base_)
            , epilogue_args(epilogue_args_) {}

        /// @brief Compatibility constructor: scale support with legacy ordering (no explicit scale_gs argument).
        inline arguments_t(uint32_t matrix_m_, uint32_t matrix_k_, uint32_t matrix_n_, matA_base_t matA_base_, uint32_t matA_ld_, matB_base_t matB_base_, uint32_t matB_ld_, matC_base_t matC_base_, uint32_t matC_ld_,
                scale_a_base_t scale_a_base_, uint32_t scale_a_ld_, scale_b_base_t scale_b_base_, uint32_t scale_b_ld_, acc_base_t acc_base_ = {}, cnt_base_t cnt_base_ = {}, epilogue_args_t epilogue_args_ = {})
            : matrix_m(matrix_m_)
            , matrix_k(matrix_k_)
            , matrix_n(matrix_n_)
            , matA_base(matA_base_)
            , matA_ld(matA_ld_)
            , matB_base(matB_base_)
            , matB_ld(matB_ld_)
            , matC_base(matC_base_)
            , matC_ld(matC_ld_)
            , scale_a_base(scale_a_base_)
            , scale_a_ld(scale_a_ld_)
            , scale_b_base(scale_b_base_)
            , scale_b_ld(scale_b_ld_)
            , scale_gs(1)
            , acc_base(acc_base_)
            , cnt_base(cnt_base_)
            , epilogue_args(epilogue_args_) {}

        inline arguments_t(const arguments_t &args)
            : matrix_m(args.matrix_m)
            , matrix_k(args.matrix_k)
            , matrix_n(args.matrix_n)
            , matA_base(args.matA_base)
            , matA_ld(args.matA_ld)
            , matB_base(args.matB_base)
            , matB_ld(args.matB_ld)
            , matC_base(args.matC_base)
            , matC_ld(args.matC_ld)
            , scale_a_base(args.scale_a_base)
            , scale_a_ld(args.scale_a_ld)
            , scale_b_base(args.scale_b_base)
            , scale_b_ld(args.scale_b_ld)
            , scale_gs(args.scale_gs)
            , acc_base(args.acc_base)
            , cnt_base(args.cnt_base)
            , epilogue_args(args.epilogue_args) {}
        // Be aware of the risks: Rule of three (copy constructor, copy assignment, destructor)
        // Please check if you need to add self-define destructor
        // inline ~arguments_t(){}
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
            this->scale_a_base = args.scale_a_base;
            this->scale_a_ld = args.scale_a_ld;
            this->scale_b_base = args.scale_b_base;
            this->scale_b_ld = args.scale_b_ld;
            this->scale_gs = args.scale_gs;
            this->acc_base = args.acc_base;
            this->cnt_base = args.cnt_base;
            this->epilogue_args = args.epilogue_args;
            return *this;
        }
    };

    /// @brief Gets named_barrier id consumption count.
    /// Users query and get a named_barrier id consumption count in compile time.
    /// @return The count of named barriers required.
    __XETLA_API static constexpr uint32_t get_barrier_count() {
        constexpr uint32_t count = scale_a_nbarr_count + gemm_nbarr_count * num_local_kslicing + kslicing_nbarr_count + epilogue_nbarr_count * num_local_kslicing;
        //static_assert(count <= 32, "The named_barrier count should be less than 32!");
        return count;
    }

    /// @brief Gets local memory size consumption.
    /// Users query and get a local memory consumption size in compile time.
    /// @return The size of local memory required.
    __XETLA_API static constexpr uint32_t get_slm_size() {
        constexpr uint32_t size = scale_a_slm_size + gemm_slm_size * num_local_kslicing + kslicing_slm_size + epilogue_slm_size * num_local_kslicing;
        static_assert(size <= (128 * 1024), "The local memory size should be less than 128KB!");
        return size;
    }

#if (XETLA_CODE_BASE == __ESIMD__)

    /// @brief Host helper function to get the expected local range under the current GEMM config.
    /// @return Expected local range.
    static sycl::range<3> get_local_range() {
        uint32_t local_range_m = (wg_tile_m + sg_tile_m - 1) / sg_tile_m;
        uint32_t local_range_n = (wg_tile_n + sg_tile_n - 1) / sg_tile_n;
        assert(local_range_m * local_range_n * num_local_kslicing <= 32);
        return sycl::range<3> {num_local_kslicing, local_range_m, local_range_n};
    };

    /// @brief Host helper function to get the expected group range under the current GEMM config.
    /// @param matrix_m Is the size of the m dimension of the matrix multiplication (m x k x n).
    /// @param matrix_n Is the size of the n dimension of the matrix multiplication (m x k x n).
    /// @return Expected group range.
    static sycl::range<3> get_group_range(uint32_t matrix_m, uint32_t matrix_n) {
        uint32_t group_range_m = (matrix_m + wg_tile_m - 1) / wg_tile_m;
        uint32_t group_range_n = (matrix_n + wg_tile_n - 1) / wg_tile_n;
        group_swizzle_t::update_group_range(group_range_m, group_range_n);
        return sycl::range<3> {num_global_kslicing, group_range_m, group_range_n};
    };

    /// @brief Host helper function to get the expected nd_range under the current GEMM config.
    /// @param args Is the GEMM arguments for application-related runtime variables.
    /// @return Expected nd_range.
    static sycl::nd_range<3> get_nd_range(arguments_t &args) {
        sycl::range<3> local_range = get_local_range();
        sycl::range<3> group_range = get_group_range(args.matrix_m, args.matrix_n);
        return sycl::nd_range<3> {group_range * local_range, local_range};
    };

    /// @brief Host helper function to get the expected accumulation buffer size of the current GEMM config.
    /// @param matrix_m Is the size of the m dimension of the matrix multiplication (m x k x n).
    /// @param matrix_n Is the size of the n dimension of the matrix multiplication (m x k x n).
    /// @return Expected accumulation buffer size in unit of elements.
    static size_t get_acc_buf_size(uint32_t matrix_m, uint32_t matrix_n) { return matrix_m * matrix_n; };

    /// @brief Host helper function to get the expected counter buffer size of the current GEMM config.
    /// @param matrix_m Is the size of the m dimension of the matrix multiplication (m x k x n).
    /// @param matrix_n Is the size of the n dimension of the matrix multiplication (m x k x n).
    /// @return Expected counter buffer size in unit of elements.
    static size_t get_cnt_buf_size(uint32_t matrix_m, uint32_t matrix_n) {
        size_t group_range_m = (matrix_m + wg_tile_m - 1) / wg_tile_m;
        size_t group_range_n = (matrix_n + wg_tile_n - 1) / wg_tile_n;
        return group_range_m * group_range_n * wg_size_y * wg_size_x * ks_coop_num_y * ks_coop_num_x * counter_size;
    };

    /// @brief Check if the arguments can be implemented.
    /// @param args Is the GEMM arguments for application-related runtime variables.
    /// @return Check result.
    static bool can_implement(arguments_t &args) {
        bool implementable = true;
        if (gemm_t::msg_type_a != msg_type::unaligned_2d) {
            if (gemm_t::msg_type_a == msg_type::block_2d) {
                implementable
                        &= kernel::block_2d<gpu_arch::Xe, dtype_a>::check_tensor((uint64_t)(args.matA_base.base), gemm_t::is_col_major_a ? args.matrix_m : args.matrix_k, gemm_t::is_col_major_a ? args.matrix_k : args.matrix_m, args.matA_ld);
            } else {
                implementable &= kernel::general_1d<gpu_arch::Xe, dtype_a>::check_alignment(args.matA_base.base, args.matA_ld);
            }
        }
        if (gemm_t::msg_type_b != msg_type::unaligned_2d) {
            if (gemm_t::msg_type_b == msg_type::block_2d) {
                implementable &= kernel::block_2d<gpu_arch::Xe, dtype_b>::check_tensor(
                        (uint64_t)(args.matB_base.base), args.matB_ld / pack_ratio * packed_row, gemm_t::is_col_major_b ? args.matrix_n : args.matrix_k, args.matB_ld / pack_ratio * packed_row);
            } else {
                implementable &= kernel::general_1d<gpu_arch::Xe, dtype_b>::check_alignment(args.matB_base.base, args.matB_ld / pack_ratio * packed_row);
            }
        }
        if (epilogue_t::msg_type_c != msg_type::unaligned_2d) {
            if (epilogue_t::msg_type_c == msg_type::block_2d) {
                implementable &= kernel::block_2d<gpu_arch::Xe, dtype_c>::check_tensor((uint64_t)(args.matC_base.base), args.matrix_n, args.matrix_m, args.matC_ld);
            } else {
                implementable &= kernel::general_1d<gpu_arch::Xe, dtype_c>::check_alignment(args.matC_base.base, args.matC_ld);
            }
        }
        // check for int2x4
        implementable &= ((args.matB_ld % pack_ratio == 0) && (args.matrix_n % pack_ratio == 0));

        return implementable;
    }

#endif

private:
    /// @brief Compute scales for matrix A rows and store in SLM.
    /// Each workgroup iterates over entire K dimension and computes one scale per row.
    /// Uses absmax row reduction: scale = 127.0 / max(abs(row_elements))
    template <int unroll_factor>
    __XETLA_API static KERNEL_FUNC void compute_scale_a_to_slm(
            work_group_t &g, const matA_base_t &matA_base, uint32_t start_m, uint32_t boundary_m, uint32_t start_k, uint32_t boundary_k, uint32_t matA_ld, uint32_t scale_slm_base, uint32_t scale_nbarrier, uint32_t scale_gs) {

        uint32_t sg_id = g.get_id();
        uint32_t rows_in_tile = boundary_m - start_m; // Process all rows in the workgroup tile

        // Create memory descriptor for matrix A access
        using matA_mem_desc_t = mem_desc_t<dtype_a, mem_layout::row_major, mem_space::global>;
        xetla_nbarrier_t<work_group_size, work_group_size, arch_tag> nbarr;
        nbarr.init_nbarrier(scale_nbarrier, nbarrier_role::producer_consumer);

        // Each subgroup computes scales for different rows to parallelize work
        // Vectorized scale computation using XETLA tile operations (similar to absmax_row_reduction)
        // Use k_stride as tile width since it perfectly divides the K range
        static constexpr uint32_t tile_width = k_stride * unroll_factor; // Use subgroup K stride for optimal vectorization
        const uint32_t tiles_per_row = boundary_k / (tile_width * scale_gs); // Perfect division assumed

        // Define tile types for vectorized processing
        using row_tile_desc_t = subgroup::tile_desc_t<tile_width, 1, tile_width, 1, reg_layout::tiled>;
        using row_tile_t = subgroup::tile_t<dtype_a, row_tile_desc_t>;
        using row_payload_t = subgroup::mem_payload_t<matA_mem_desc_t, row_tile_desc_t, subgroup::msg_type_v<row_tile_desc_t, mem_space::global>, arch_tag>;
        using row_prefetch_payload_t = subgroup::prefetch_payload_t<matA_mem_desc_t, row_tile_desc_t, tile_width, gpu_arch::Xe>;

        row_tile_t row_tile;

        // Each subgroup processes rows with stride equal to the number of subgroups
#pragma unroll
        for (uint32_t row_idx = sg_id; row_idx < rows_in_tile; row_idx += work_group_size) {
            uint32_t global_row = start_m + row_idx;
            // Create row payload for this specific row (covers tile_width elements)
            row_payload_t row_payload(matA_base.base + global_row * matA_ld, tile_width, 1, matA_ld, 0, 0);
            row_prefetch_payload_t row_payload_prefetch(matA_base.base + global_row * matA_ld, tile_width, 1, matA_ld, 0, 0);

            // Process row in vectorized tiles (perfect division, no partial tiles)
            for (int igs = 0; igs < scale_gs; igs++) {
                // Initialize vectorized accumulator for maximum values
                xetla_vector<float, tile_width> acc_vec = FLT_EPSILON;
                xetla_vector<float, tile_width> src_reg_f32;
                xetla_mask<tile_width> mask_max;
#pragma unroll
                for (uint32_t tile_idx = 0; tile_idx < tiles_per_row; tile_idx++) {
                    subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(row_payload_prefetch);
                    row_payload_prefetch.template update_tdesc<tdesc_update_dir::x_dir>(row_tile_t::tile_size_x);
                }
#pragma unroll
                for (uint32_t tile_idx = 0; tile_idx < tiles_per_row; tile_idx++) {
                    // Load vectorized tile data
                    subgroup::tile_load<cache_hint::cached, cache_hint::cached>(row_tile, row_payload);
                    row_payload.template update_tdesc<tdesc_update_dir::x_dir>(row_tile_t::tile_size_x);

                    // Convert to float and compute absolute values (vectorized)
                    src_reg_f32 = xetla_abs<float, tile_width>(xetla_cvt<float, dtype_a, tile_width>(row_tile.reg.xetla_select<tile_width, 1>(0)));
                    // Vectorized maximum comparison and merge
                    mask_max = src_reg_f32 > acc_vec;
                    acc_vec.xetla_merge(src_reg_f32, acc_vec, mask_max);
                }
                // Reduce vector to single maximum value
                float max_abs_val = xetla_reduce<float, float, tile_width, reduce_op::max>(acc_vec);
                // Store to SLM using proper XETLA SLM store
                xetla_store_local<float, 1>(scale_slm_base + (row_idx + igs * rows_in_tile) * sizeof(float), 127.0f / max_abs_val);
            }
        }

        // Barrier to ensure all scales are computed before GEMM reads them
        xetla_fence<memory_kind::shared_local>();
        nbarr.arrive_wait();
    }

public:
    /// @brief Main execution function for GEMM.
    /// The processing order is 1) set group-level base and boundary, split group to workgroups ->
    /// 2) num_local_kslicing x gemms -> 3) local kslicing -> 4) num_local_kslicing x epilogues.
    /// @param Is the sycl::nd_item, returns execution related information, such as workgroup id, subgroup id...
    /// @param args Is the GEMM arguments for application-related runtime variables.
    /// @param slm_base Is the slm base address.
    /// @param nbarrier_base Is the named barrier base.
    __XETLA_API KERNEL_FUNC void operator()(sycl::nd_item<3> &item, const arguments_t &args, uint32_t slm_base = 0, uint32_t nbarrier_base = 0) {
        // set up workgroup level coordinates and boundaries
        work_group_t g(item.get_local_linear_id() % work_group_size);
        uint32_t wg_id = item.get_local_linear_id() / work_group_size;
        group_swizzle_t group_swizzle;
        int start_m = group_swizzle.template get_tile_idx<1>(item) * wg_tile_m;
        int start_n = group_swizzle.template get_tile_idx<2>(item) * wg_tile_n;
        int start_k = 0;
        uint32_t wg_tile_k = args.matrix_k;
        uint32_t boundary_n = (start_n + wg_tile_n) > args.matrix_n ? args.matrix_n : (start_n + wg_tile_n);
        uint32_t boundary_m = (start_m + wg_tile_m) > args.matrix_m ? args.matrix_m : (start_m + wg_tile_m);
        uint32_t boundary_k = wg_tile_k;
        if constexpr (num_global_kslicing > 1) {
            wg_tile_k = (wg_tile_k + num_global_kslicing - 1) / num_global_kslicing;
            start_k = start_k + group_swizzle.template get_tile_idx<0>(item) * wg_tile_k;
            boundary_k = (start_k + wg_tile_k) > boundary_k ? boundary_k : (start_k + wg_tile_k);
        }
        if constexpr (num_local_kslicing > 1) {
            wg_tile_k = (wg_tile_k + num_local_kslicing - 1) / num_local_kslicing;
            start_k = start_k + wg_id * wg_tile_k;
            boundary_k = (start_k + wg_tile_k) > boundary_k ? boundary_k : (start_k + wg_tile_k);
        }

        // set up arguments - scale_a comes first in SLM and barriers if used internally
        uint32_t scale_a_slm_base = slm_base;
        uint32_t scale_a_nbarr = nbarrier_base;
        
        uint32_t gemm_slm_base = slm_base + scale_a_slm_size;
        uint32_t gemm_nbarr_base = nbarrier_base + scale_a_nbarr_count;
        if constexpr (num_local_kslicing > 1) {
            gemm_slm_base = slm_base + scale_a_slm_size + wg_id * gemm_slm_size;
            gemm_nbarr_base = nbarrier_base + scale_a_nbarr_count + wg_id * gemm_nbarr_count;
        }
        uint32_t kslicing_slm_base = slm_base + scale_a_slm_size + num_local_kslicing * gemm_slm_size;
        uint32_t kslicing_nbarr_base = nbarrier_base + scale_a_nbarr_count + num_local_kslicing * gemm_nbarr_count;
        uint32_t epilogue_slm_base = kslicing_slm_base + kslicing_slm_size;
        uint32_t epilogue_nbarr_base = kslicing_nbarr_base + kslicing_nbarr_count;

        mem_desc_a_t mem_desc_a;
        mem_desc_b_t mem_desc_b;
        mem_desc_c_t mem_desc_c;
        //setup for matA

        mem_desc_a.init(args.matA_base, {boundary_k, boundary_m, args.matA_ld}, {start_k, start_m});
        mem_desc_b.init(args.matB_base, {boundary_n / pack_ratio * packed_row, boundary_k / packed_row, args.matB_ld / pack_ratio * packed_row}, {int(start_n / pack_ratio * packed_row), int(start_k / packed_row)});

        // Create scale descriptors - conditional based on use_external_scale_a
        mem_desc_scale_a_t mem_desc_scale_a;
        
        if constexpr (use_external_scale_a) {
            // External scale A: use global memory descriptor from args
            uint32_t scale_a_size_x = args.matrix_m;
            uint32_t scale_a_size_y = args.scale_gs;
            mem_desc_scale_a.init(args.scale_a_base, {scale_a_size_x, scale_a_size_y, args.scale_a_ld}, {static_cast<int>(start_m), static_cast<int>(start_k / (args.matrix_k / args.scale_gs))});
        } else {
            // Internal scale A: compute in SLM redundantly.
            // Choose the largest unroll_factor whose tile (k_stride * unroll_factor)
            // still fits inside one scale group (group_k = matrix_k / scale_gs).
            // tile_width must satisfy: tile_width <= group_k, i.e.
            //   k_stride * unroll_factor <= matrix_k / scale_gs
            //   <=> unroll_factor <= matrix_k / (k_stride * scale_gs)
            // Without this dispatch, large scale_gs makes tiles_per_row underflow to 0
            // and the per-row absmax is never updated, producing huge bogus scales.
            if (args.matrix_k >= 2u * k_stride * args.scale_gs) {
                compute_scale_a_to_slm<2>(g, args.matA_base, start_m, boundary_m, 0, args.matrix_k, args.matA_ld, scale_a_slm_base, scale_a_nbarr, args.scale_gs);
            } else {
                compute_scale_a_to_slm<1>(g, args.matA_base, start_m, boundary_m, 0, args.matrix_k, args.matA_ld, scale_a_slm_base, scale_a_nbarr, args.scale_gs);
            }
            
            // Create SLM memory descriptor - 2D tensor [rows, scale_gs]
            uint32_t scale_a_rows = boundary_m - start_m;
            mem_desc_scale_a.init(scale_a_slm_base, {scale_a_rows, args.scale_gs, scale_a_rows}, {0, 0});
        }

        uint32_t scale_b_size_y = args.scale_gs;
        uint32_t scale_b_size_x = args.matrix_n;
        mem_desc_scale_b_t mem_desc_scale_b(args.scale_b_base, {scale_b_size_x, scale_b_size_y, args.scale_b_ld}, {static_cast<int>(start_n), static_cast<int>(start_k / (args.matrix_k / args.scale_gs))});

        uint32_t inner_loop_count = (wg_tile_k + k_stride - 1) / k_stride;
        gemm_args_t gemm_args(mem_desc_a, mem_desc_b, inner_loop_count, mem_desc_scale_a, mem_desc_scale_b);
        gemm_args.scale_gs = args.scale_gs;
        gemm_args.num_global_kslicing = num_global_kslicing;

        // If both global and local kslicing == 1 we can call gemm direct-write overload
        // (gemm writing into matC) to avoid the accumulator->epilogue flow.
        if constexpr ((num_global_kslicing == 1) && (num_local_kslicing == 1)) {
            // Use FP32 accumulator tile type (same tile layout as matAcc_t)
            using matAcc_f_t = subgroup::tile_t<float, typename gemm_t::matAcc_tile_desc_t>;
            // Define the same cooperative kslicing types as the kslicing path
            using kslicing_f_t = group::cooperative_reduce_t<reduce_op::sum, tile_shape, matAcc_f_t, num_local_kslicing, arch_tag>;
            using mat_slice_f_t = typename kslicing_f_t::mat_slice_t;

            gemm_t gemm;
            matAcc_f_t matAcc_f;
            matAcc_f.init(0);

            gemm.template operator()<float, gemm_args_t>(g, matAcc_f, gemm_args, gemm_slm_base, gemm_nbarr_base);

            // Since num_local_kslicing == 1, the cooperative reduce is a pass-through
            // but produces the correct mat_slice_f_t type expected by epilogue
            kslicing_f_t kslicing_f(0); // wg_id = 0 since there's only one workgroup in k-dimension
            mat_slice_f_t mat_slice_f;
            kslicing_f(g, mat_slice_f, matAcc_f, kslicing_slm_base, kslicing_nbarr_base);

            if (kslicing_f.is_valid_post_process_wg()) {
                // Compute offsets for this workgroup's tile
                int32_t coop_offset_x = kslicing_f.coop_id_x * mat_slice_f_t::tile_size_x;
                int32_t coop_offset_y = kslicing_f.coop_id_y * mat_slice_f_t::tile_size_y;

                mem_desc_c.init(args.matC_base, {boundary_n, boundary_m, args.matC_ld}, {start_n + coop_offset_x, start_m + coop_offset_y});

                // Apply epilogue with post-ops on the FP32 mat_slice_f tile
                epilogue_t epilogue;
                epilogue(g, mat_slice_f, mem_desc_c, args.epilogue_args, epilogue_slm_base, epilogue_nbarr_base);
            }

            // direct-write case finished; nothing further to do here
            return;
        } else {
            // If global kslicing > 1 we prefer to produce FP32 accumulator tiles from gemm
            // so that reductions happen in FP32. Otherwise use the original int32 path.
            // FP32 accumulator tile type (same tile layout as matAcc_t)
            using matAcc_f_t = subgroup::tile_t<float, typename gemm_t::matAcc_tile_desc_t>;
            // Cooperative kslicing type for FP32 per-local-slice reduction
            using kslicing_f_t = group::cooperative_reduce_t<reduce_op::sum, tile_shape, matAcc_f_t, num_local_kslicing, arch_tag>;
            using mat_slice_f_t = typename kslicing_f_t::mat_slice_t;
            // Global reduction type that reduces into a global float accumulation buffer
            using mem_desc_acc_f_t = mem_desc_t<float, mem_layout::row_major, mem_space::global>;
            using global_group_reduce_f_t = group::global_reduce_t<reduce_op::sum, tile_shape, tile_shape_cnt, mem_desc_acc_f_t, mem_desc_cnt_t, num_global_kslicing, counter_size, arch_tag>;

            // Run gemm that writes FP32 accumulator tiles
            matAcc_f_t matAcc_f;
            matAcc_f.init(0);
            gemm_t gemm;
            gemm.template operator()<float, gemm_args_t>(g, matAcc_f, gemm_args, gemm_slm_base, gemm_nbarr_base);

            // Local cooperative kslicing reduction (FP32)
            kslicing_f_t kslicing_f(wg_id);
            mat_slice_f_t mat_slice_f;
            kslicing_f(g, mat_slice_f, matAcc_f, kslicing_slm_base, kslicing_nbarr_base);

            if (kslicing_f.is_valid_post_process_wg()) {
                // setup for matC (same offsets as before)
                int32_t coop_offset_x = kslicing_f.coop_id_x * mat_slice_f_t::tile_size_x;
                int32_t coop_offset_y = kslicing_f.coop_id_y * mat_slice_f_t::tile_size_y;
                int32_t acc_start_x = start_n + coop_offset_x;
                int32_t acc_start_y = start_m + coop_offset_y;
                int32_t cnt_start_x = group_swizzle.template get_tile_idx<2>(item) * tile_shape_cnt::wg_tile_size_x + kslicing_f.coop_id_x;
                int32_t cnt_start_y = group_swizzle.template get_tile_idx<1>(item) * tile_shape_cnt::wg_tile_size_y + kslicing_f.coop_id_y;
                uint32_t group_range_x = item.get_group_range(2);
                uint32_t group_range_y = item.get_group_range(1);
                uint32_t cnt_size_x = group_range_x * tile_shape_cnt::wg_tile_size_x;
                uint32_t cnt_size_y = group_range_y * tile_shape_cnt::wg_tile_size_y;

                mem_desc_acc_f_t mem_desc_acc_f(mem_desc_acc_f_t::base_t(reinterpret_cast<float *>(args.acc_base.base)), {boundary_n, boundary_m, args.matrix_n}, {acc_start_x, acc_start_y});
                mem_desc_cnt_t mem_desc_cnt(args.cnt_base, {cnt_size_x, cnt_size_y, cnt_size_x}, {cnt_start_x, cnt_start_y});

                global_group_reduce_f_t global_group_reduce_f;
                global_group_reduce_f(g, mat_slice_f, mem_desc_acc_f, mem_desc_cnt);

                if (global_group_reduce_f.is_last_group()) {
                    if constexpr (mem_desc_c_t::is_local) {
                        mem_desc_c.init(args.matC_base, {real_wg_tile_n, real_wg_tile_m, real_wg_tile_n}, {coop_offset_x, coop_offset_y});
                    } else {
                        mem_desc_c.init(args.matC_base, {boundary_n, boundary_m, args.matC_ld}, {start_n + coop_offset_x, start_m + coop_offset_y});
                    }
                    epilogue_t epilogue;
                    epilogue(g, mat_slice_f, mem_desc_c, args.epilogue_args, epilogue_slm_base, epilogue_nbarr_base);
                }
            }
        }
    }
};

/// @} xetla_gemm

} // namespace gpu::xetla::kernel
