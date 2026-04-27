# Check for ccache and enable if available
CCACHE := $(shell command -v ccache 2> /dev/null)
ifdef CCACHE
    CXX = ccache icpx
    $(info ✅ ccache enabled for faster recompilation)
    export CCACHE_CPP2=yes
    export CCACHE_SLOPPINESS=pch_defines,time_macros,include_file_mtime,include_file_ctime
    export CCACHE_COMPRESS=true
    export CCACHE_COMPRESSLEVEL=6
    export CCACHE_MAXSIZE=10G
else
    CXX = icpx
    $(info ℹ️  ccache not found - install ccache for faster recompilation)
endif

CXXFLAGS = -std=c++20 -O3 -fsycl -qopenmp -I../include -I../tests -I../tests/utils -I../tests/integration/gemm -I../tests/3rd_parties/googletest/googletest/include
LDFLAGS = -lmkl_rt -lpthread -qopenmp
SRCDIR = src
BUILDDIR = build
TARGET = $(BUILDDIR)/int2_fast_test

# Build gtest from source (excluding gtest_main since we provide our own main)
GTEST_DIR = ../tests/3rd_parties/googletest/googletest
GTEST_SOURCES = $(GTEST_DIR)/src/gtest-all.cc
GTEST_OBJECTS = $(BUILDDIR)/gtest-all.o

# Source files - explicitly list to control compilation order and dependencies
SOURCES = $(SRCDIR)/main.cpp \
          $(SRCDIR)/precompiled_gemm.cpp \
          $(SRCDIR)/precompiled_gemm_1.cpp \
          $(SRCDIR)/precompiled_gemm_2.cpp \
          $(SRCDIR)/precompiled_gemm_3.cpp \
          $(SRCDIR)/precompiled_gemm_4.cpp \
          $(SRCDIR)/precompiled_gemm_5.cpp \
          $(SRCDIR)/precompiled_gemm_6.cpp \
          $(SRCDIR)/precompiled_gemm_7.cpp \
          $(SRCDIR)/precompiled_gemm_8.cpp \
          $(SRCDIR)/precompiled_gemm_9.cpp \
          $(SRCDIR)/precompiled_gemm_10.cpp \
          $(SRCDIR)/precompiled_gemm_11.cpp \
          $(SRCDIR)/precompiled_gemm_12.cpp \
          $(SRCDIR)/precompiled_gemm_13.cpp \
          $(SRCDIR)/precompiled_gemv.cpp \
          $(SRCDIR)/precompiled_gemv_1.cpp \
          $(SRCDIR)/variant_registry.cpp

OBJECTS = $(SOURCES:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

# Headers that all compilation units depend on
COMMON_HEADERS = $(SRCDIR)/variant_common.hpp \
                 ../include/experimental/group/gemm/impl/int2_fp16_dpas_xmx_xe.hpp
				 
# Critical: Track the INT2 header so changes trigger rebuild
INT2_HEADER = ../include/experimental/group/gemm/impl/int2_fp16_dpas_xmx_xe.hpp
REDUCE_HEADER = ../tests/unit/tile_row_reduction/kernel_func.hpp

.PHONY: all clean test fast benchmark watch help ccache-stats ccache-clear

all: $(TARGET)

$(TARGET): $(OBJECTS) $(GTEST_OBJECTS) | $(BUILDDIR)
	@echo "🔗 Linking INT2 test..."
	@$(CXX) $(CXXFLAGS) $(OBJECTS) $(GTEST_OBJECTS) -o $@ $(LDFLAGS)
	@echo "✅ INT2 test built successfully!"

# Separate rules for main.cpp (doesn't depend on variant templates) and variant files
$(BUILDDIR)/main.o: $(SRCDIR)/main.cpp $(SRCDIR)/variant_common.hpp $(REDUCE_HEADER) | $(BUILDDIR)
	@echo "🔨 Compiling main.cpp with template instantiations..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Precompiled GEMM variants - aggregator (fast)
$(BUILDDIR)/precompiled_gemm.o: $(SRCDIR)/precompiled_gemm.cpp $(SRCDIR)/variant_common.hpp | $(BUILDDIR)
	@echo "🔨 Compiling GEMM aggregator..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Precompiled GEMM variants - split units (can compile in parallel)
$(BUILDDIR)/precompiled_gemm_1.o: $(SRCDIR)/precompiled_gemm_1.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 1/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_2.o: $(SRCDIR)/precompiled_gemm_2.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 2/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_3.o: $(SRCDIR)/precompiled_gemm_3.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 3/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_4.o: $(SRCDIR)/precompiled_gemm_4.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 4/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_5.o: $(SRCDIR)/precompiled_gemm_5.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 5/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_6.o: $(SRCDIR)/precompiled_gemm_6.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 6/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_7.o: $(SRCDIR)/precompiled_gemm_7.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 7/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_8.o: $(SRCDIR)/precompiled_gemm_8.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 8/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_9.o: $(SRCDIR)/precompiled_gemm_9.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 9/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_10.o: $(SRCDIR)/precompiled_gemm_10.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 10/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_11.o: $(SRCDIR)/precompiled_gemm_11.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 11/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_12.o: $(SRCDIR)/precompiled_gemm_12.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 12/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemm_13.o: $(SRCDIR)/precompiled_gemm_13.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMM variants 13/13..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Precompiled GEMV variants (expensive compilation)
$(BUILDDIR)/precompiled_gemv.o: $(SRCDIR)/precompiled_gemv.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling precompiled GEMV aggregator..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/precompiled_gemv_1.o: $(SRCDIR)/precompiled_gemv_1.cpp $(COMMON_HEADERS) | $(BUILDDIR)
	@echo "🔨 Compiling GEMV variants 1..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Variant registry (links GEMM and GEMV together)
$(BUILDDIR)/variant_registry.o: $(SRCDIR)/variant_registry.cpp $(SRCDIR)/variant_common.hpp | $(BUILDDIR)
	@echo "🔨 Compiling variant registry..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/gtest-all.o: $(GTEST_DIR)/src/gtest-all.cc | $(BUILDDIR)
	@echo "🔨 Compiling gtest..."
	@$(CXX) $(CXXFLAGS) -I$(GTEST_DIR) -c $< -o $@

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

fast: $(TARGET)
	@echo "⚡ Fast build completed"

test: $(TARGET)
	@echo "🧪 Running INT2 test..."
	@./$(TARGET)

clean:
	@rm -rf $(BUILDDIR)

watch:
	@echo "👁️ Watching INT2 file for changes..."
	@while inotifywait -q -e modify $(INT2_HEADER); do \
		echo "📁 INT2 algorithm changed, rebuilding..."; \
		make fast && echo "✅ Rebuild completed at $$(date)"; \
	done

ccache-stats:
ifdef CCACHE
	@echo "📊 ccache Statistics:"
	@ccache -s
else
	@echo "❌ ccache not found - install ccache to use this feature"
endif

ccache-clear:
ifdef CCACHE
	@echo "🗑️  Clearing ccache..."
	@ccache -C
	@echo "✅ ccache cleared"
else
	@echo "❌ ccache not found - nothing to clear"
endif

help:
	@echo "🚀 INT2 Fast Development Environment"
	@echo "Available targets:"
	@echo "  fast         - Fast build (2-3 seconds)"
	@echo "  test         - Build and run the INT2 dequantization test"
	@echo "  watch        - Auto-rebuild on INT2 header changes"
	@echo "  clean        - Remove build artifacts"
	@echo "  ccache-stats - Show ccache statistics"
	@echo "  ccache-clear - Clear ccache"

.PRECIOUS: $(BUILDDIR)/%.o
