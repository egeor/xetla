#include <sycl/sycl.hpp>
#include <cstdio>
int main() {
  sycl::queue q{sycl::gpu_selector_v};
  auto d = q.get_device();
  printf("device      : %s\n", d.get_info<sycl::info::device::name>().c_str());
  printf("local_mem   : %llu bytes (%.1f KB)\n",
         (unsigned long long)d.get_info<sycl::info::device::local_mem_size>(),
         d.get_info<sycl::info::device::local_mem_size>()/1024.0);
  printf("max_wg_size : %llu\n",
         (unsigned long long)d.get_info<sycl::info::device::max_work_group_size>());
  printf("EUs         : %u\n", d.get_info<sycl::info::device::max_compute_units>());
  return 0;
}
