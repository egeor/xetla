# Check for ccache and enable if available
CCACHE := $(shell command -v ccache 2> /dev/null)
ifdef CCACHE
    CXX = ccache icpx
    $(info ccache enabled for faster recompilation)
    export CCACHE_CPP2=yes
    export CCACHE_SLOPPINESS=pch_defines,time_macros,include_file_mtime,include_file_ctime
    export CCACHE_COMPRESS=true
    export CCACHE_COMPRESSLEVEL=6
    export CCACHE_MAXSIZE=10G
else
    CXX = icpx
    $(info ccache not found - install ccache for faster recompilation)
endif

CXXFLAGS = -std=c++20 -O3 -fsycl -qopenmp -I../include -I../tests -I../tests/utils -I../tests/integration/gemm -I../tests/3rd_parties/googletest/googletest/include
LDFLAGS = -lmkl_rt -lpthread -qopenmp
SRCDIR = src
BUILDDIR = build
TARGET = $(BUILDDIR)/int2_fp16scales_test

# Build gtest from source (excluding gtest_main since we provide our own main)
GTEST_DIR = ../tests/3rd_parties/googletest/googletest
GTEST_SOURCES = $(GTEST_DIR)/src/gtest-all.cc
GTEST_OBJECTS = $(BUILDDIR)/gtest-all.o

# Source files - 14-tile slim build (all instantiations live in main.cpp)
SOURCES = $(SRCDIR)/main.cpp \
          $(SRCDIR)/precompiled_gemm.cpp \
          $(SRCDIR)/variant_registry.cpp

OBJECTS = $(SOURCES:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

# Headers that all compilation units depend on
COMMON_HEADERS = $(SRCDIR)/variant_common.hpp \
                 ../include/experimental/group/gemm/impl/int2_fp16_dpas_xmx_xe.hpp

INT2_HEADER = ../include/experimental/group/gemm/impl/int2_fp16_dpas_xmx_xe.hpp
REDUCE_HEADER = ../tests/unit/tile_row_reduction/kernel_func.hpp

.PHONY: all clean test fast help ccache-stats ccache-clear

all: $(TARGET)

$(TARGET): $(OBJECTS) $(GTEST_OBJECTS) | $(BUILDDIR)
	@echo "Linking int2 fp16-scales test..."
	@$(CXX) $(CXXFLAGS) $(OBJECTS) $(GTEST_OBJECTS) -o $@ $(LDFLAGS)
	@echo "Built $(TARGET)"

$(BUILDDIR)/main.o: $(SRCDIR)/main.cpp $(SRCDIR)/variant_common.hpp $(REDUCE_HEADER) | $(BUILDDIR)
	@echo "Compiling main.cpp..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm.o: $(SRCDIR)/precompiled_gemm.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "Compiling precompiled_gemm.cpp..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/variant_registry.o: $(SRCDIR)/variant_registry.cpp $(SRCDIR)/variant_common.hpp | $(BUILDDIR)
	@echo "Compiling variant_registry.cpp..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/gtest-all.o: $(GTEST_DIR)/src/gtest-all.cc | $(BUILDDIR)
	@echo "Compiling gtest..."
	@$(CXX) $(CXXFLAGS) -I$(GTEST_DIR) -c $< -o $@

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

fast: $(TARGET)

test: $(TARGET)
	@./$(TARGET)

clean:
	@rm -rf $(BUILDDIR)

ccache-stats:
ifdef CCACHE
	@ccache -s
else
	@echo "ccache not found"
endif

ccache-clear:
ifdef CCACHE
	@ccache -C
else
	@echo "ccache not found"
endif

help:
	@echo "int2 fp16-scales test"
	@echo "  fast/all     - Build the test"
	@echo "  test         - Build and run with defaults"
	@echo "  clean        - Remove build artifacts"

.PRECIOUS: $(BUILDDIR)/%.o
