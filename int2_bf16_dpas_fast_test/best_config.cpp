#include <iostream>
#include <map>
#include <numeric>
#include <string>
#include <tuple>
#include <vector>
#include <sycl/sycl.hpp>

std::tuple<int, int, int, int, int, int> get_best_config(int M, int N, int K, std::string platform) {
    // Xe2 configs
    static const std::map<std::pair<int,int>, std::tuple<int,int,int,int,int,int>> best_gemm_configs_xe2 = {
        { {4096,2048}, {64,8,128,128,32,1} },
        { {2048,2048}, {32,8,256,128,64,1} },
        { {8192,2048}, {32,8,256,128,64,1} },
        { {2048,8192}, {64,8,256,128,64,1} },
        { {2240,1600}, {64,8,160,160,32,1} },
        { {1600,1600}, {32,8,160,160,32,1} },
        { {4352,1600}, {32,8,256,128,64,1} },
        { {1600,4352}, {64,8,160,160,32,1} },
        { {6144,4096}, {64,8,256,128,64,1} },
        { {4096,4096}, {64,8,256,128,64,1} },
        { {14336,4096}, {64,8,256,128,64,1} },
        { {4096,14336}, {64,8,256,128,64,1} },
    };
    static const std::map<std::pair<int,int>, std::tuple<int,int,int,int,int,int>> best_gemv_configs_xe2 = {
        { {4096,2048}, {1,1,128,16,128,0} },
        { {2048,2048}, {1,1,32,16,256,0} },
        { {8192,2048}, {1,1,128,32,128,0} },
        { {2048,8192}, {1,1,128,32,256,0} },
        { {2240,1600}, {1,1,32,16,160,0} },
        { {1600,1600}, {1,1,32,16,160,0} },
        { {4352,1600}, {1,1,128,16,160,0} },
        { {1600,4352}, {1,1,32,32,256,0} },
        { {6144,4096}, {1,1,128,16,128,0} },
        { {4096,4096}, {1,1,128,16,128,0} },
        { {14336,4096}, {1,1,128,32,128,0} },
        { {4096,14336}, {1,1,128,16,128,0} },
    };
    // LNL configs
    static const std::map<std::pair<int,int>, std::tuple<int,int,int,int,int,int>> best_gemm_configs_lnl = {
        { {4096,2048}, {32,8,256,128,64,1} },
        { {2048,2048}, {32,8,128,128,32,1} },
        { {8192,2048}, {64,8,128,128,32,1} },
        { {2048,8192}, {64,8,256,128,32,1} },
        { {2240,1600}, {64,8,160,160,32,1} },
        { {1600,1600}, {64,8,160,160,32,1} },
        { {4352,1600}, {16,8,256,128,32,1} },
        { {1600,4352}, {64,8,160,160,32,1} },
        { {6144,4096}, {16,8,256,128,32,1} },
        { {4096,4096}, {32,8,256,128,32,1} },
        { {14336,4096}, {128,8,128,128,32,1} },
        { {4096,14336}, {128,8,128,128,64,1} },
    };
    static const std::map<std::pair<int,int>, std::tuple<int,int,int,int,int,int>> best_gemv_configs_lnl = {
        { {4096,2048}, {1,1,128,128,32,0} },
        { {2048,2048}, {1,1,64,16,128,0} },
        { {8192,2048}, {1,1,128,32,32,1} },
        { {2048,8192}, {1,1,32,32,128,0} },
        { {2240,1600}, {1,1,80,16,160,0} },
        { {1600,1600}, {1,1,64,16,160,0} },
        { {4352,1600}, {1,1,128,32,160,0} },
        { {1600,4352}, {1,1,64,16,256,0} },
        { {6144,4096}, {1,1,32,32,32,1} },
        { {4096,4096}, {1,1,128,32,32,0} },
        { {14336,4096}, {1,1,128,32,32,1} },
        { {4096,14336}, {1,1,32,32,32,1} },
    };

    const std::map<std::pair<int,int>, std::tuple<int,int,int,int,int,int>> *best_gemm_configs = nullptr;
    const std::map<std::pair<int,int>, std::tuple<int,int,int,int,int,int>> *best_gemv_configs = nullptr;
    if (platform == "xe2") {
        best_gemm_configs = &best_gemm_configs_xe2;
        best_gemv_configs = &best_gemv_configs_xe2;
    } else if (platform == "lnl") {
        best_gemm_configs = &best_gemm_configs_lnl;
        best_gemv_configs = &best_gemv_configs_lnl;
    } else {
        throw std::invalid_argument("Unknown platform: " + platform);
    }
    if (M > 1) {
        auto it = best_gemm_configs->find({N,K});
        if (it != best_gemm_configs->end()) {
            auto t = it->second;
            int wg_m = std::min(M, std::gcd(M, std::get<0>(t)));
            int sg_m = std::min(M, std::gcd(M, std::get<1>(t)));
            int wg_n = std::min(N, std::gcd(N, std::get<2>(t)));
            int sg_n = std::min(N, std::gcd(N, std::get<3>(t)));
            int sg_k = std::min(K, std::gcd(K, std::get<4>(t)));
            int external_scale_a_calc = std::get<5>(t);
            return std::make_tuple(wg_m, sg_m, wg_n, sg_n, sg_k, external_scale_a_calc);
        }
        // GEMM default (use gcd logic)
        return std::make_tuple(std::min(M,std::gcd(M,64)), 8, std::min(N,std::gcd(N,256)), std::min(N,std::gcd(N,128)), std::min(K,std::gcd(K,64)), 1);
    } else {
        auto it = best_gemv_configs->find({N,K});
        if (it != best_gemv_configs->end()) {
            auto t = it->second;
            int wg_m = std::min(M, std::gcd(M, std::get<0>(t)));
            int sg_m = std::min(M, std::gcd(M, std::get<1>(t)));
            int wg_n = std::min(N, std::gcd(N, std::get<2>(t)));
            int sg_n = std::min(N, std::gcd(N, std::get<3>(t)));
            int sg_k = std::min(K, std::gcd(K, std::get<4>(t)));
            int external_scale_a_calc = std::get<5>(t);
            return std::make_tuple(wg_m, sg_m, wg_n, sg_n, sg_k, external_scale_a_calc);
        }
        // GEMV default (use gcd logic)
        return std::make_tuple(1,1,std::min(N,std::gcd(N,128)),std::min(N,std::gcd(N,32)),std::min(K,std::gcd(K,128)),0);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 4 || argc > 5) {
        std::cerr << "Usage: " << argv[0] << " M N K [PLATFORM]" << std::endl;
        return 1;
    }
    int M = std::stoi(argv[1]);
    int N = std::stoi(argv[2]);
    int K = std::stoi(argv[3]);
    std::string platform = (argc == 5) ? argv[4] : "";
    std::tuple<int,int,int,int,int,int> config;

    // Autodetect platform if not provided
    if (platform.empty()) {
        std::vector<sycl::platform> platforms = sycl::platform::get_platforms();
        for (const auto &plat : platforms) {
            std::vector<sycl::device> devices = plat.get_devices();
            for (const auto &device : devices) {
                std::string dev_name = device.get_info<sycl::info::device::name>();
                if (dev_name.find("B580") != std::string::npos) {
                    platform = "xe2";
                    std::cout << "Found Xe2 platform..." << std::endl;
                    break;
                }
                if (dev_name.find("258V") != std::string::npos) {
                    platform = "lnl";
                    std::cout << "Found LNL platform..." << std::endl;
                    break;
                }
            }
            if (!platform.empty()) break;
        }
        if (platform.empty()) {
            std::cout << "Could not auto-detect GPU platform, defaulting to xe2 configuration" << std::endl;
            platform = "xe2";
        }
    }

    try {
        config = get_best_config(M, N, K, platform);
    } catch (const std::invalid_argument& e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }
    std::cout << "wg_m=" << std::get<0>(config)
              << " sg_m=" << std::get<1>(config)
              << " wg_n=" << std::get<2>(config)
              << " sg_n=" << std::get<3>(config)
              << " sg_k=" << std::get<4>(config)
              << " external_scale_a_calc=" << std::get<5>(config)
              << std::endl;
#ifdef PRINT_EXEC_CMD
    std::cout << "ONEAPI_DEVICE_SELECTOR=opencl:gpu OMP_NUM_THREADS=16 ./build/int2_fast_test -v0"
              << " --mat_m=" << M
              << " --mat_n=" << N
              << " --mat_k=" << K
              << " --global_kslicing=1 --scale_gs=1"
              << " --wg_m=" << std::get<0>(config)
              << " --sg_m=" << std::get<1>(config)
              << " --wg_n=" << std::get<2>(config)
              << " --sg_n=" << std::get<3>(config)
              << " --sg_k=" << std::get<4>(config)
              << " --external_scale_a_calc=" << std::get<5>(config)
              << " --iters=20"
              << std::endl;
#endif
    return 0;
}
