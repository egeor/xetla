# Minimal Makefile for int2_fp16_upcvt_dpas_fast_test
# Builds a single main.cpp that exercises the new int2 fp16 upcvt GEMM variant.

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
           -I../include -I../tests -I../tests/utils \
           -I../tests/integration/gemm \
           -I../tests/3rd_parties/googletest/googletest/include
LDFLAGS  = -lpthread -qopenmp

SRCDIR   = src
BUILDDIR = build
TARGET   = $(BUILDDIR)/int2_fp16_upcvt_test

GTEST_DIR     = ../tests/3rd_parties/googletest/googletest
GTEST_OBJECTS = $(BUILDDIR)/gtest-all.o

OBJECTS = $(BUILDDIR)/main.o

INT2_GROUP_HEADER  = ../include/experimental/group/gemm/impl/int2_fp16_upcvt_xmx_xe.hpp
INT2_KERNEL_HEADER = ../include/experimental/kernel/gemm/impl/int2_fp16_upcvt_kslicing_xe.hpp

.PHONY: all clean test help

all: $(TARGET)

$(TARGET): $(OBJECTS) $(GTEST_OBJECTS) | $(BUILDDIR)
	@echo "Linking int2 fp16 upcvt test..."
	@$(CXX) $(CXXFLAGS) $(OBJECTS) $(GTEST_OBJECTS) -o $@ $(LDFLAGS)
	@echo "Built $@"

$(BUILDDIR)/main.o: $(SRCDIR)/main.cpp $(INT2_GROUP_HEADER) $(INT2_KERNEL_HEADER) | $(BUILDDIR)
	@echo "Compiling main.cpp..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/gtest-all.o: $(GTEST_DIR)/src/gtest-all.cc | $(BUILDDIR)
	@echo "Compiling gtest..."
	@$(CXX) $(CXXFLAGS) -I$(GTEST_DIR) -c $< -o $@

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

test: $(TARGET)
	@echo "Running int2 fp16 upcvt test..."
	@./$(TARGET)

clean:
	@rm -rf $(BUILDDIR)

help:
	@echo "Targets:"
	@echo "  all   - Build $(TARGET)"
	@echo "  test  - Build and run"
	@echo "  clean - Remove build artifacts"
