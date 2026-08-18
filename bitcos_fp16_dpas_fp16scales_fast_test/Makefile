# Minimal Makefile for bitcos_fp16_dpas_fp16scales_fast_test
# Builds a single main.cpp that exercises the BITCOS ternary GEMM variant.

CCACHE := $(shell command -v ccache 2> /dev/null)
ifdef CCACHE
    CXX = ccache icpx
    export CCACHE_CPP2=yes
    export CCACHE_SLOPPINESS=pch_defines,time_macros,include_file_mtime,include_file_ctime
    export CCACHE_COMPRESS=true
    export CCACHE_COMPRESSLEVEL=6
    export CCACHE_MAXSIZE=10G
else
    CXX = icpx
endif

CXXFLAGS = -std=c++20 -O3 -fsycl -qopenmp \
		   -DBITCOS_FP16_LUT -DBITCOS_SIGN_GATHER4 -DBITCOS_FP_STORE \
           -I../include -I../tests -I../tests/utils \
           -I../tests/integration/gemm \
           -I../tests/3rd_parties/googletest/googletest/include
LDFLAGS  = -lpthread -qopenmp

SRCDIR   = src
BUILDDIR = build
TARGET   = $(BUILDDIR)/bitcos_fp16_test

GTEST_DIR     = ../tests/3rd_parties/googletest/googletest
GTEST_OBJECTS = $(BUILDDIR)/gtest-all.o

OBJECTS = $(BUILDDIR)/main.o

INT1_GROUP_HEADER  = ../include/experimental/group/gemm/impl/bitcos_fp16_upcvt_xmx_xe.hpp
INT1_KERNEL_HEADER = ../include/experimental/kernel/gemm/impl/bitcos_fp16_upcvt_kslicing_xe.hpp

.PHONY: all clean test help

all: $(TARGET)

$(TARGET): $(OBJECTS) $(GTEST_OBJECTS) | $(BUILDDIR)
	@echo "Linking bitcos fp16 test..."
	@$(CXX) $(CXXFLAGS) $(OBJECTS) $(GTEST_OBJECTS) -o $@ $(LDFLAGS)
	@echo "Built $@"

$(BUILDDIR)/main.o: $(SRCDIR)/main.cpp $(INT1_GROUP_HEADER) $(INT1_KERNEL_HEADER) | $(BUILDDIR)
	@echo "Compiling main.cpp..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/gtest-all.o: $(GTEST_DIR)/src/gtest-all.cc | $(BUILDDIR)
	@echo "Compiling gtest..."
	@$(CXX) $(CXXFLAGS) -I$(GTEST_DIR) -c $< -o $@

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

test: $(TARGET)
	@echo "Running int1 fp16 upcvt test..."
	@./$(TARGET)

s2_probe: $(BUILDDIR)/s2_probe

$(BUILDDIR)/s2_probe: $(SRCDIR)/s2_probe.cpp $(SRCDIR)/bitcos_format.hpp | $(BUILDDIR)
	@echo "Compiling s2_probe.cpp..."
	@$(CXX) $(CXXFLAGS) -I$(SRCDIR) $< -o $@ $(LDFLAGS)
	@echo "Built $@"

clean:
	@rm -rf $(BUILDDIR)

help:
	@echo "Targets:"
	@echo "  all   - Build $(TARGET)"
	@echo "  test  - Build and run"
	@echo "  clean - Remove build artifacts"
