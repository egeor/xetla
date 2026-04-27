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

#ifdef _WIN32
#include "../../../../experimental/group/gemm/common.hpp"
#include "../../../../experimental/group/gemm/compute_policy.hpp"
#else
#include "experimental/group/gemm/common.hpp"
#include "experimental/group/gemm/compute_policy.hpp"
#endif

namespace gpu::xetla::group {

/// @addtogroup xetla_gemm
/// @{

/// @brief Is the gemm functor for Xe architecture with DPAS instruction for int2_fp16.
template <typename compute_attr_, typename perf_tuning_knob_, typename dtype_scale_a_, typename dtype_scale_b_, int mma_xmx_m_, gpu_arch arch_tag_,
          typename tile_shape_, typename mem_desc_a_t_, typename mem_desc_b_t_, typename pre_processing_t_>
class gemm_t<compute_policy_int2_fp16_dpas_xmx<compute_attr_, perf_tuning_knob_, dtype_scale_a_, dtype_scale_b_, mma_xmx_m_, arch_tag_>,
               tile_shape_, // tile shape of workgroup-level gemm
               mem_desc_a_t_, // memory attribute of matA
               mem_desc_b_t_, // memory attribute of matB
               pre_processing_t_, // pre_processing functor
               std::enable_if_t<(arch_tag_ == gpu_arch::Xe)
                       >> {
public:
    using compute_policy = compute_policy_int2_fp16_dpas_xmx<compute_attr_, perf_tuning_knob_, dtype_scale_a_, dtype_scale_b_, mma_xmx_m_, arch_tag_>;
    using mem_desc_a_t = mem_desc_a_t_;
    using mem_desc_b_t = mem_desc_b_t_;
    using tile_shape = tile_shape_;
    using pre_processing_t = pre_processing_t_;
    static constexpr uint32_t k_stride = compute_policy::k_stride;
    static constexpr uint32_t mma_xmx_m = compute_policy::mma_xmx_m;
    // scale_gs removed as compile-time alias intentionally. scale_gs is a
    // runtime parameter carried in arguments_t and should not appear in the
    // compute_policy or gemm_t compile-time interface.

    // Scale-related type definitions
    using dtype_scale_a = typename compute_policy::dtype_scale_a;
    using dtype_scale_b = typename compute_policy::dtype_scale_b;
    // Default to global memory for backward compatibility; kernel layer can override via template arguments
    using mem_desc_scale_a_t = mem_desc_t<dtype_scale_a, mem_layout::row_major, mem_space::global>;
    using mem_desc_scale_b_t = mem_desc_t<dtype_scale_b, mem_layout::row_major, mem_space::global>;

    static constexpr uint32_t sg_tile_m = tile_shape::sg_tile_size_y;
    static constexpr uint32_t sg_tile_n = tile_shape::sg_tile_size_x;
    static constexpr uint32_t wg_size_x = tile_shape::wg_size_x;
    static constexpr uint32_t wg_size_y = tile_shape::wg_size_y;
    using work_group_t = typename tile_shape::work_group_t;

    constexpr static gpu_arch arch_tag = compute_policy::arch_tag;
    using dtype_b = typename mem_desc_b_t::dtype;
    static constexpr uint32_t pack_ratio = get_packed_num<dtype_b>::value;
    static constexpr uint32_t packed_row = pack_ratio;
    static constexpr mem_layout mem_layout_a = mem_desc_a_t::layout;
    static constexpr mem_layout mem_layout_b = mem_desc_b_t::layout;
    static constexpr bool is_col_major_a = mem_layout_a == mem_layout::col_major;
    static constexpr bool is_col_major_b = mem_layout_b == mem_layout::col_major;

private:
    /******** set data type **********/
    using dtype_a = typename mem_desc_a_t::dtype;
    using dtype_mma_acc = typename compute_policy::dtype_mma_acc;
    using dtype_mma_a = typename compute_policy::dtype_mma_a;
    using dtype_mma_b = typename compute_policy::dtype_mma_b;

    static_assert(std::is_same<remove_const_t<dtype_b>, remove_const_t<int2x16>>::value, "this is for 2bit matB ");

    // Debug: Check that dtype_mma_b is also int2x16 for DPAS
    static_assert(std::is_same<remove_const_t<dtype_mma_b>, remove_const_t<int2x16>>::value, "dtype_mma_b should be int2x16 for DPAS operations");

    /******** set memory attribute **********/
    static constexpr mem_space mem_space_a = mem_desc_a_t::space;
    static constexpr mem_space mem_space_b = mem_desc_b_t::space;

    static constexpr bool is_local_a = mem_space_a == mem_space::local;
    static constexpr bool is_local_b = mem_space_b == mem_space::local;
    static constexpr tdesc_update_dir update_dir_a = is_col_major_a ? tdesc_update_dir::y_dir : tdesc_update_dir::x_dir;
    static constexpr tdesc_update_dir update_dir_b = is_col_major_b ? tdesc_update_dir::x_dir : tdesc_update_dir::y_dir;
    static_assert(!is_col_major_b, "only support MatB row-major for now");
    static_assert((!is_local_a) && (!is_local_b), "only support  from global memory for now");

    static constexpr uint32_t stages = compute_policy::stages;
    static constexpr uint32_t scale_stages = 0;//compute_policy::stages;

    static constexpr uint32_t sync_freq = compute_policy::sync_freq;

    /******** set tile layout && worker scope **********/
    static constexpr uint32_t tile_size_x_a = k_stride;
    static constexpr uint32_t tile_size_y_a = sg_tile_m;
    static constexpr uint32_t tile_size_x_b = sg_tile_n;
    static constexpr uint32_t tile_size_y_b = k_stride;
    static constexpr uint32_t tile_size_x_c = sg_tile_n;
    static constexpr uint32_t tile_size_y_c = sg_tile_m;
    static constexpr uint32_t block_size_x_a = compute_policy::block_bytes_x_a / sizeof(dtype_mma_a);
    static constexpr uint32_t block_size_y_a = (compute_policy::block_size_y_a > tile_size_y_a) ? tile_size_y_a : compute_policy::block_size_y_a;

    static constexpr uint32_t block_size_x_b = compute_policy::block_size_x_b;
    static constexpr uint32_t block_size_y_b = compute_policy::block_bytes_y_b;

    /******** set tile  **********/
    static_assert(packed_row > 0, "packed_row must be greater than 0");
    static_assert(tile_size_y_b >= packed_row, "tile_size_y_b must be >= packed_row");
    static_assert(block_size_y_b >= packed_row, "block_size_y_b must be >= packed_row");
    static constexpr reg_layout reg_layout_a = reg_layout::tiled;
    using matA_tile_desc_t = subgroup::tile_desc_t<tile_size_x_a, tile_size_y_a, block_size_x_a, block_size_y_a, reg_layout_a>;
    using matA_t = subgroup::tile_t<dtype_a, matA_tile_desc_t>;
    using matA_payload_t = subgroup::mem_payload_t<mem_desc_a_t, matA_tile_desc_t, msg_type::block_2d, arch_tag>;
    using matA_acc_t = subgroup::tile_t<dtype_mma_a, matA_tile_desc_t>;
    using matA_prefetch_payload_t = subgroup::prefetch_payload_t<mem_desc_a_t, subgroup::tile_desc_t<tile_size_x_a, tile_size_y_a, 1, 1>, wg_size_x, arch_tag>;

    using matB_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b, tile_size_y_b / pack_ratio, block_size_x_b, block_size_y_b / pack_ratio, reg_layout::tiled>;
    using matB_t = subgroup::tile_t<dtype_b, matB_tile_desc_t>;
    using matB_payload_t = subgroup::mem_payload_t<mem_desc_b_t, matB_tile_desc_t, msg_type::block_2d, arch_tag>;
    using matB_prefetch_payload_t = subgroup::prefetch_payload_t<mem_desc_b_t, matB_tile_desc_t, wg_size_y, arch_tag>;

    using matB_acc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_b, tile_size_y_b / pack_ratio, block_size_x_b, block_size_y_b / pack_ratio, reg_layout::vnni_tiled>;
    using matB_acc_t = subgroup::tile_t<dtype_mma_b, matB_acc_tile_desc_t>;

public:
    static_assert((k_stride % (block_size_y_b) == 0), "k_stride%(block_size_y_b) == 0");

    using matAcc_tile_desc_t = subgroup::tile_desc_t<tile_size_x_c, tile_size_y_c, block_size_x_b, block_size_y_a, reg_layout::tiled>;
    using matAcc_t = subgroup::tile_t<dtype_mma_acc, matAcc_tile_desc_t>;

    // Add output matrix C type definitions - will be provided via template parameter
    template <typename dtype_c_>
    using matC_tile_desc_t = subgroup::tile_desc_t<tile_size_x_c, tile_size_y_c, block_size_x_b, block_size_y_a, reg_layout::tiled>;
    template <typename dtype_c_>
    using matC_t = subgroup::tile_t<dtype_c_, matC_tile_desc_t<dtype_c_>>;

private:
    // Use standard tile_mma_t with custom mma_attr from compute_policy
    // Note: The 7th parameter (enable) is computed by std::enable_if_t, and the 8th is our custom mma_attr
    using tile_mma = subgroup::tile_mma_t<matAcc_t, matAcc_t, matB_acc_t, matA_acc_t,
                                          mma_engine::xmx, arch_tag,
                                          typename std::enable_if<(arch_tag == gpu_arch::Xe)
                                          >::type,
                                          typename compute_policy::arch_attr::mma_attr>;
    static constexpr bool enable_periodic_sync = (sync_freq != 0);
    static constexpr uint32_t barrier_count_x = wg_size_y > 1 ? wg_size_x : 0;
    static constexpr uint32_t barrier_count_y = wg_size_x > 1 ? wg_size_y : 0;

public:
    static constexpr uint32_t barrier_count = enable_periodic_sync ? barrier_count_x + barrier_count_y : 0;

    static constexpr uint32_t slm_size = 0;

    static constexpr msg_type msg_type_a = matA_payload_t::message_type;
    static constexpr msg_type msg_type_b = matB_payload_t::message_type;

    /// @brief Arguments for gemm - templated to accept different scale memory descriptor types.
    /// User should prepare matA_base_desc, matB_base_desc, inner_loop_count...
    template <typename mem_desc_scale_a_t_, typename mem_desc_scale_b_t_>
    struct arguments_tmpl_t {
        using mem_desc_scale_a_t_arg = mem_desc_scale_a_t_;
        using mem_desc_scale_b_t_arg = mem_desc_scale_b_t_;
        
        /// @brief Is the memory description of matA, including base, shape and coordinate.
        mem_desc_a_t matA_base_desc;
        /// @brief Is the memory description of matB, including base, shape and coordinate.
        mem_desc_b_t matB_base_desc;
        /// @brief Is the total inner loop count required to compute the entire K-dim.
        uint32_t inner_loop_count;
        /// @brief Is the memory description of scale buffer for matrix A. Scale size: (matrix_m)x(matrix_k/scale_gs)
        mem_desc_scale_a_t_ scale_a_base_desc;
        /// @brief Is the memory description of scale buffer for matrix B. Scale size: (matrix_k/scale_gs)x(matrix_n)
        mem_desc_scale_b_t_ scale_b_base_desc;
        /// @brief Runtime scale group size (previously a compile-time parameter)
        uint32_t scale_gs; // must be provided by caller at runtime
        /// @brief Runtime number of global kslicing groups. Set by kernel dispatch (default 1).
        uint32_t num_global_kslicing = 1;

        /// @brief Default construct.
        inline arguments_tmpl_t() = default;

        inline arguments_tmpl_t(mem_desc_a_t matA_desc, mem_desc_b_t matB_desc, uint32_t loop_count, mem_desc_scale_a_t_ scale_a_desc, mem_desc_scale_b_t_ scale_b_desc)
            : matA_base_desc(matA_desc), matB_base_desc(matB_desc), inner_loop_count(loop_count), scale_a_base_desc(scale_a_desc), scale_b_base_desc(scale_b_desc), scale_gs(1), num_global_kslicing(1) {}
        // Be aware of the risks: Rule of three (copy constructor, copy assignment, destructor)
        // Please check if you need to add self-define destructor
        // inline ~arguments_tmpl_t(){}
        inline arguments_tmpl_t(const arguments_tmpl_t &args)
            : matA_base_desc(args.matA_base_desc), matB_base_desc(args.matB_base_desc), inner_loop_count(args.inner_loop_count), scale_a_base_desc(args.scale_a_base_desc), scale_b_base_desc(args.scale_b_base_desc), scale_gs(args.scale_gs), num_global_kslicing(args.num_global_kslicing) {}
        inline arguments_tmpl_t &operator=(const arguments_tmpl_t &args) {
            this->matA_base_desc = args.matA_base_desc;
            this->matB_base_desc = args.matB_base_desc;
            this->inner_loop_count = args.inner_loop_count;
            this->scale_a_base_desc = args.scale_a_base_desc;
            this->scale_b_base_desc = args.scale_b_base_desc;
            this->scale_gs = args.scale_gs;
            this->num_global_kslicing = args.num_global_kslicing;
            return *this;
        }
        inline void init(mem_desc_a_t matA_desc, mem_desc_b_t matB_desc, uint32_t loop_count, mem_desc_scale_a_t_ scale_a_desc, mem_desc_scale_b_t_ scale_b_desc) {
            matA_base_desc = matA_desc;
            matB_base_desc = matB_desc;
            inner_loop_count = loop_count;
            scale_a_base_desc = scale_a_desc;
            scale_b_base_desc = scale_b_desc;
            // Note: scale_gs and num_global_kslicing are runtime fields and should be set by the caller/kernel dispatch; do not assume defaults here beyond construction.
        }
    };
    
    /// @brief Default arguments_t uses global memory for both scales (backward compatibility)
    using arguments_t = arguments_tmpl_t<mem_desc_scale_a_t, mem_desc_scale_b_t>;

    /// @brief Gets the subgroup-level tile offset x.
    /// @param g Is the workgroup of the current tile.
    /// @return Subgroup-level tile offset x.
    __XETLA_API static int get_matC_offset_x(work_group_t &g) {
        int32_t sg_idx = g.get_id() % wg_size_x;
        return sg_idx * sg_tile_n;
    }

    /// @brief Gets the subgroup-level tile offset y.
    /// @param g Is the workgroup of the current tile.
    /// @return Subgroup-level tile offset y.
    __XETLA_API static int get_matC_offset_y(work_group_t &g) {
        int32_t sg_idy = g.get_id() / wg_size_x;
        return sg_idy * sg_tile_m;
    }

    XETLA_MARKER(
            "This release function will wait until all the  r/w and nbarrier "
            "id used in this gemm have been committed. By default, it will "
            "use barrier_id 0 to do the entire workgroup sync if wg_size > 1. "
            "If you call this function, please set a free barrier id or make "
            "sure barrier_id 0 is not being occupied and you need to allocate "
            "one more barrier count in addition to the gemm barrier counts.")
    __XETLA_API static void release(uint8_t nbarrier_id = 0) {
        static constexpr bool need_local_fence = (mem_space_a == mem_space::local) || (mem_space_b == mem_space::local);
        if constexpr (need_local_fence) { xetla_fence<memory_kind::shared_local>(); }
        xetla_fence<memory_kind::untyped_global>();
        static constexpr uint32_t wg_size = wg_size_x * wg_size_y;
        if constexpr (wg_size > 1) {
            xetla_nbarrier_t<wg_size, wg_size, arch_tag> nbarrier;
            nbarrier.init_nbarrier(nbarrier_id, nbarrier_role::producer_consumer);
            nbarrier.arrive_wait();
        }
    }

    /// @brief Main execution function for gemm with direct output to matC.
    /// The basic process is load data -> matrix multiply -> write to output C.
    /// @tparam matC_t Is the type of the output matrix C tile.
    /// @param g Is the workgroup of the current tile.
    /// @param matC Is the reference of the output matrix C buffer.
    /// @param args Is the gemm::arguments_t.
    /// @param slm_base Is the slm base address.
    /// @param nbarrier_base Is the named barrier base.
    template <typename matC_t>
    __XETLA_API KERNEL_FUNC void operator()(work_group_t &g, matC_t &matC, arguments_t args, uint32_t slm_base = 0, uint32_t nbarrier_base = 0) {
        int32_t sg_idx = g.get_id() % wg_size_x;
        int32_t sg_idy = g.get_id() / wg_size_x;
        update_sg_tile_tdesc(args, sg_idx, sg_idy);

        // Create local accumulator for computation in higher precision
        matAcc_t matAcc;
        matAcc.init(0); // Zero-initialize the accumulator

        matA_t matA;
        matB_t matB;

        matA_payload_t matA_payload(args.matA_base_desc);
        matB_payload_t matB_payload(args.matB_base_desc);

        matA_prefetch_payload_t matA_prefetch_payload(args.matA_base_desc, sg_idx);
        matB_prefetch_payload_t matB_prefetch_payload(args.matB_base_desc, sg_idy);

        xetla_nbarrier_t<wg_size_x, wg_size_x, arch_tag> nbarrier_a;
        nbarrier_a.init_nbarrier(sg_idy + nbarrier_base, nbarrier_role::producer_consumer);
        xetla_nbarrier_t<wg_size_y, wg_size_y, arch_tag> nbarrier_b;
        nbarrier_b.init_nbarrier(sg_idx + barrier_count_y + nbarrier_base, nbarrier_role::producer_consumer);

        SW_BARRIER();
#pragma unroll
        for (int i = 0; i < stages; i++) {
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matA_prefetch_payload);
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matB_prefetch_payload);
        }

        for (int i = 0; i < args.inner_loop_count; i++) {
            if constexpr (enable_periodic_sync) {
                if ((i % sync_freq) == 0) {
                    if constexpr (wg_size_x > 1) { nbarrier_a.arrive(); }
                    if constexpr (wg_size_y > 1) { nbarrier_b.arrive(); }
                }
            }
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matA, matA_payload);
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matB, matB_payload);
            SW_BARRIER();
            if constexpr (stages != 0) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matA_prefetch_payload);
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matB_prefetch_payload);
            }
            SW_BARRIER();
            matA_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
            matB_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
            if constexpr (stages != 0) {
                matA_prefetch_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
                matB_prefetch_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
            }
            SW_BARRIER();
            matA_acc_t matA_acc;
            matB_acc_t matB_acc;
            subgroup::elemwise_cvt(matA_acc, matA);
            subgroup::elemwise_cvt(matB_acc, matB);
            SW_BARRIER();
            tile_mma::mma(matAcc, matAcc, matB_acc, matA_acc);
            SW_BARRIER();
            if constexpr (enable_periodic_sync) {
                if ((i % sync_freq) == 0) {
                    if constexpr (wg_size_x > 1) { nbarrier_a.wait(); }
                    if constexpr (wg_size_y > 1) { nbarrier_b.wait(); }
                }
            }
        }
        SW_BARRIER();

        // Convert accumulator precision to output precision and store to matC
        // Load scalar scales from the provided scale memory descriptors (single-element load)
        if (1) {
            //auto tdesc_a = args.scale_a_base_desc.get_tdesc();
            //auto scaleA_vec = xetla_tload_global<dtype_scale_a, 1>(tdesc_a);
            float scale_A = 1.0; //static_cast<float>(scaleA_vec[0]);

            //auto tdesc_b = args.scale_b_base_desc.get_tdesc();
            //auto scaleB_vec = xetla_tload_global<dtype_scale_b, 1>(tdesc_b);
            float scale_B = 1.0; //static_cast<float>(scaleB_vec[0]);

            subgroup::elemwise_scale_output(matC, matAcc, scale_A, scale_B);
        }
    }

    /// @brief Original execution function for gemm (for backward compatibility).
    /// The basic process is load data -> matrix multiply.
    /// @param g Is the workgroup of the current tile.
    /// @param matAcc Is the reference of the accumulation buffer.
    /// @param args Is the gemm::arguments_t.
    /// @param slm_base Is the slm base address.
    /// @param nbarrier_base Is the named barrier base.
    __XETLA_API KERNEL_FUNC void operator()(work_group_t &g, matAcc_t &matAcc, arguments_t args, uint32_t slm_base = 0, uint32_t nbarrier_base = 0) {
        int32_t sg_idx = g.get_id() % wg_size_x;
        int32_t sg_idy = g.get_id() / wg_size_x;
        update_sg_tile_tdesc(args, sg_idx, sg_idy);

        matA_t matA;
        matB_t matB;

        matA_payload_t matA_payload(args.matA_base_desc);
        matB_payload_t matB_payload(args.matB_base_desc);

        matA_prefetch_payload_t matA_prefetch_payload(args.matA_base_desc, sg_idx);
        matB_prefetch_payload_t matB_prefetch_payload(args.matB_base_desc, sg_idy);

        xetla_nbarrier_t<wg_size_x, wg_size_x, arch_tag> nbarrier_a;
        nbarrier_a.init_nbarrier(sg_idy + nbarrier_base, nbarrier_role::producer_consumer);
        xetla_nbarrier_t<wg_size_y, wg_size_y, arch_tag> nbarrier_b;
        nbarrier_b.init_nbarrier(sg_idx + barrier_count_y + nbarrier_base, nbarrier_role::producer_consumer);

        SW_BARRIER();
#pragma unroll
        for (int i = 0; i < stages; i++) {
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matA_prefetch_payload);
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matB_prefetch_payload);
        }

        for (int i = 0; i < args.inner_loop_count; i++) {
            if constexpr (enable_periodic_sync) {
                if ((i % sync_freq) == 0) {
                    if constexpr (wg_size_x > 1) { nbarrier_a.arrive(); }
                    if constexpr (wg_size_y > 1) { nbarrier_b.arrive(); }
                }
            }
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matA, matA_payload);
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matB, matB_payload);
            SW_BARRIER();
            if constexpr (stages != 0) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matA_prefetch_payload);
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matB_prefetch_payload);
            }
            SW_BARRIER();
            matA_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
            matB_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
            if constexpr (stages != 0) {
                matA_prefetch_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
                matB_prefetch_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
            }
            SW_BARRIER();
            matA_acc_t matA_acc;
            matB_acc_t matB_acc;
            subgroup::elemwise_cvt(matA_acc, matA);
            subgroup::elemwise_cvt(matB_acc, matB);
            SW_BARRIER();
            tile_mma::mma(matAcc, matAcc, matB_acc, matA_acc);
            SW_BARRIER();
            if constexpr (enable_periodic_sync) {
                if ((i % sync_freq) == 0) {
                    if constexpr (wg_size_x > 1) { nbarrier_a.wait(); }
                    if constexpr (wg_size_y > 1) { nbarrier_b.wait(); }
                }
            }
        }
        SW_BARRIER();
    }

    // Unified templated overload to support float and fp16 output tiles without duplicating the implementation
    template <typename OutT, typename ArgsT>
    __XETLA_API KERNEL_FUNC void operator()(work_group_t &g, subgroup::tile_t<OutT, matAcc_tile_desc_t> &matAcc_f, ArgsT args, uint32_t slm_base = 0, uint32_t nbarrier_base = 0) {
        static_assert(std::is_same_v<OutT, float> || std::is_same_v<OutT, fp16>, "Unsupported output tile element type");
        int32_t sg_idx = g.get_id() % wg_size_x;
        int32_t sg_idy = g.get_id() / wg_size_x;
        update_sg_tile_tdesc(args, sg_idx, sg_idy);

        // Detect memory space of scale_a from descriptor type in args
        using scale_a_desc_t = typename ArgsT::mem_desc_scale_a_t_arg;
        static constexpr mem_space scale_a_mem_space = scale_a_desc_t::space;

        // Load scale tiles for A and B and apply elementwise scaling
        // scales_A layout: (ks_groups rows x M columns)
        // Determine compile-time scale-A tile width: use compute_policy override if provided, else sg_tile_m
        static constexpr uint32_t scale_a_tile_m = sg_tile_m;
        // We want to load a contiguous slice of M corresponding to subgroup rows -> tile_x = scale_a_tile_m, tile_y = 1
        using scaleA_tile_desc_t = subgroup::tile_desc_t<scale_a_tile_m, 1, 1, 1, reg_layout::tiled>;
        using scaleB_tile_desc_t = subgroup::tile_desc_t<sg_tile_n, 1, 1, 1, reg_layout::tiled>;
        using scaleA_t = subgroup::tile_t<dtype_scale_a, scaleA_tile_desc_t>;
        using scaleB_t = subgroup::tile_t<dtype_scale_b, scaleB_tile_desc_t>;
        // Use the scale descriptor types from arguments
        using scale_b_desc_t = typename ArgsT::mem_desc_scale_b_t_arg;
        // Use block_1d for both global and SLM
        using scaleA_payload_t = subgroup::mem_payload_t<scale_a_desc_t, scaleA_tile_desc_t, msg_type::block_1d, arch_tag>;
        using scaleB_payload_t = subgroup::mem_payload_t<scale_b_desc_t, scaleB_tile_desc_t, msg_type::block_1d, arch_tag>;

        // Prefetch payload types for scales (only for global memory)
        using scaleA_prefetch_payload_t = subgroup::prefetch_payload_t<scale_a_desc_t, scaleA_tile_desc_t, wg_size_x, arch_tag>;
        using scaleB_prefetch_payload_t = subgroup::prefetch_payload_t<scale_b_desc_t, scaleB_tile_desc_t, wg_size_y, arch_tag>;

        scaleA_t scaleA_tile;
        scaleB_t scaleB_tile;

        scaleA_payload_t scaleA_payload(args.scale_a_base_desc);
        scaleB_payload_t scaleB_payload(args.scale_b_base_desc);

        // Prefetch payloads for matA, matB and scales
        matA_prefetch_payload_t matA_prefetch_payload(args.matA_base_desc, sg_idx);
        matB_prefetch_payload_t matB_prefetch_payload(args.matB_base_desc, sg_idy);
        // Only initialize prefetch for global memory scales (not SLM)
        [[maybe_unused]] scaleA_prefetch_payload_t scaleA_prefetch_payload(args.scale_a_base_desc, sg_idx);
        [[maybe_unused]] scaleB_prefetch_payload_t scaleB_prefetch_payload(args.scale_b_base_desc, sg_idy);

        // Internal int32 accumulator used by MMA
        using matAcc_f_t = subgroup::tile_t<float, typename gemm_t::matAcc_tile_desc_t>;
        matAcc_f_t matAcc_local_f32;
        matAcc_t matAcc_local;
        matA_t matA;
        matB_t matB;

        matA_payload_t matA_payload(args.matA_base_desc);
        matB_payload_t matB_payload(args.matB_base_desc);

        xetla_nbarrier_t<wg_size_x, wg_size_x, arch_tag> nbarrier_a;
        nbarrier_a.init_nbarrier(sg_idy + nbarrier_base, nbarrier_role::producer_consumer);
        xetla_nbarrier_t<wg_size_y, wg_size_y, arch_tag> nbarrier_b;
        nbarrier_b.init_nbarrier(sg_idx + barrier_count_y + nbarrier_base, nbarrier_role::producer_consumer);

        SW_BARRIER();
#pragma unroll
        for (int i = 0; i < stages; i++) {
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matA_prefetch_payload);
            subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matB_prefetch_payload);
            // Prefetch next scale tiles - only for global memory (not SLM)
            if constexpr (scale_stages != 0) {
                if constexpr (scale_a_mem_space == mem_space::global) {
                    subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(scaleA_prefetch_payload);
                }
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(scaleB_prefetch_payload);
            }

            matA_prefetch_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_y);
            matB_prefetch_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);

            // Advance scale prefetch descriptors along ks-group axis (ks_groups are rows in Y)
            if constexpr (scale_stages != 0) {
                if constexpr (scale_a_mem_space == mem_space::global) { scaleA_prefetch_payload.template update_tdesc<tdesc_update_dir::y_dir>(1); }
                scaleB_prefetch_payload.template update_tdesc<tdesc_update_dir::y_dir>(1);
            }
        }

        auto k_iters = args.inner_loop_count;
        auto k_total_iters = k_iters * args.num_global_kslicing;
        auto k_chunk_global = k_total_iters / args.scale_gs;
        auto k_groups = (k_iters + k_chunk_global - 1) / k_chunk_global;
        auto k_chunks = k_iters / k_groups;

        matAcc_local_f32.init(0);
        for (int igk = 0; igk < k_groups; igk++) {
            matAcc_local.init(0);
            // Load scales A and B
            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(scaleA_tile, scaleA_payload);
            scaleA_payload.template update_tdesc<tdesc_update_dir::y_dir>(1);

            // Prefetch next scale only for global memory (not SLM)
            if constexpr ((scale_stages != 0) && (scale_a_mem_space == mem_space::global)) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(scaleA_prefetch_payload);
                scaleA_prefetch_payload.template update_tdesc<tdesc_update_dir::y_dir>(1);
            }

            for (int j = 0; j < k_chunks - stages; j++) {
                int i = igk * k_chunks + j;
                if constexpr (enable_periodic_sync) {
                    if ((i % sync_freq) == 0) {
                        if constexpr (wg_size_x > 1) { nbarrier_a.arrive(); }
                        if constexpr (wg_size_y > 1) { nbarrier_b.arrive(); }
                    }
                }
                subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matA, matA_payload);
                subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matB, matB_payload);
                SW_BARRIER();
                if constexpr (stages != 0) {
                    subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matA_prefetch_payload);
                    subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(matB_prefetch_payload);
                }
                SW_BARRIER();
                matA_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
                matB_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
                if constexpr (stages != 0) {
                    matA_prefetch_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
                    matB_prefetch_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
                }
                SW_BARRIER();
                matA_acc_t matA_acc;
                matB_acc_t matB_acc;
                //subgroup::elemwise_cvt(matA_acc, matA);
                subgroup::elemwise_scale_fp16_to_int8(matA_acc, matA, scaleA_tile);
                subgroup::elemwise_cvt(matB_acc, matB);
                SW_BARRIER();
                tile_mma::mma(matAcc_local, matAcc_local, matB_acc, matA_acc);
                SW_BARRIER();
                if constexpr (enable_periodic_sync) {
                    if ((i % sync_freq) == 0) {
                        if constexpr (wg_size_x > 1) { nbarrier_a.wait(); }
                        if constexpr (wg_size_y > 1) { nbarrier_b.wait(); }
                    }
                }
            }

            for (int j = k_chunks - stages; j < k_chunks; j++) {
                int i = igk * k_chunks + j;
                if constexpr (enable_periodic_sync) {
                    if ((i % sync_freq) == 0) {
                        if constexpr (wg_size_x > 1) { nbarrier_a.arrive(); }
                        if constexpr (wg_size_y > 1) { nbarrier_b.arrive(); }
                    }
                }
                subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matA, matA_payload);
                subgroup::tile_load<cache_hint::cached, cache_hint::cached>(matB, matB_payload);
                SW_BARRIER();
                matA_payload.template update_tdesc<update_dir_a>(matA_t::tile_size_x);
                matB_payload.template update_tdesc<update_dir_b>(matB_t::tile_size_y);
                SW_BARRIER();
                matA_acc_t matA_acc;
                matB_acc_t matB_acc;
                //subgroup::elemwise_cvt(matA_acc, matA);
                subgroup::elemwise_scale_fp16_to_int8(matA_acc, matA, scaleA_tile);
                subgroup::elemwise_cvt(matB_acc, matB);
                SW_BARRIER();
                tile_mma::mma(matAcc_local, matAcc_local, matB_acc, matA_acc);
                SW_BARRIER();
                if constexpr (enable_periodic_sync) {
                    if ((i % sync_freq) == 0) {
                        if constexpr (wg_size_x > 1) { nbarrier_a.wait(); }
                        if constexpr (wg_size_y > 1) { nbarrier_b.wait(); }
                    }
                }
            }

            SW_BARRIER();

            subgroup::tile_load<cache_hint::cached, cache_hint::cached>(scaleB_tile, scaleB_payload);
            if constexpr (scale_stages != 0) {
                subgroup::tile_prefetch<cache_hint::cached, cache_hint::cached>(scaleB_prefetch_payload);
            }
            scaleB_payload.template update_tdesc<tdesc_update_dir::y_dir>(1);

            if constexpr (scale_stages != 0) {
                scaleB_prefetch_payload.template update_tdesc<tdesc_update_dir::y_dir>(1);
            }
            SW_BARRIER();

            // Convert accumulator to OutT and apply per-element scales
            // Some subgroup APIs accept mixed types; rely on elemwise_scale_output overloads for OutT
            subgroup::elemwise_scale_output(matAcc_local_f32, matAcc_local, scaleA_tile, scaleB_tile);
        }

        constexpr uint32_t elems = matAcc_tile_desc_t::tile_elems;
        matAcc_f.reg += xetla_cvt<OutT, float, elems>(matAcc_local_f32.reg);
    }

private:
    /// @brief Updates tile base descriptor based on the tid.
    template <typename ArgsT>
    __XETLA_API static void update_sg_tile_tdesc(ArgsT &args, int32_t sg_idx, int32_t sg_idy) {
        int32_t tile_offset_n = sg_idx * sg_tile_n;
        int32_t tile_offset_m = sg_idy * sg_tile_m;

        args.matA_base_desc.update_coord_y(tile_offset_m);
        args.matB_base_desc.update_coord_x(tile_offset_n);

        // For scales_A layout (ks_groups rows x M columns) the subgroup's row offset
        // (tile_offset_m) maps to the X coordinate (columns) within the scale matrix.
        args.scale_a_base_desc.update_coord_x(tile_offset_m); // move to subgroup's columns in A
        args.scale_b_base_desc.update_coord_x(tile_offset_n); // move to subgroup's cols in B
    }
};

/// @} xetla_gemm

} // namespace gpu::xetla::group
