#!/bin/sh
set -e

if [ "$CONDA_BUILD_CROSS_COMPILATION" = "1" ]; then
	export PYTHON="${BUILD_PREFIX}/bin/python"
fi

cmake -B build $CMAKE_ARGS \
	-DPython3_EXECUTABLE=$PYTHON \
	-DCMAKE_CXX_FLAGS="$CXXFLAGS -D_LIBCPP_DISABLE_AVAILABILITY"
cmake --build build -j$CPU_COUNT
cmake --install build

echo "===== Installed Files ====="
find $PREFIX
echo "===== End of Installed Files ====="
