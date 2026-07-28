// Minimal stand-in for <gtest/gtest.h>.
//
// The standalone tuning driver (src/main.cpp) does not use googletest at all,
// but it pulls in ../tests/utils/profiling.hpp which calls
// ::testing::Test::RecordProperty() to publish kernel timings as XML test
// properties. Rather than vendoring the whole googletest tree just for that,
// we provide a no-op shim so the driver can be built standalone.
#pragma once

#include <string>

namespace testing {

class Test {
 public:
  template <typename T>
  static void RecordProperty(const std::string&, const T&) {}
  static void RecordProperty(const std::string&, const char*) {}
};

}  // namespace testing
