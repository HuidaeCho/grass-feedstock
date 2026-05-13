#!/bin/sh
set -e

if [ "$CONDA_BUILD_CROSS_COMPILATION" = "1" ]; then
	export PYTHON="${BUILD_PREFIX}/bin/python"
	export CC="$CC_FOR_BUILD"
	export CXX="$CXX_FOR_BUILD"
	export AR="$AR_FOR_BUILD"
	export RANLIB="$RANLIB_FOR_BUILD"
	export CPPFLAGS="-I$BUILD_PREFIX/include $CPPFLAGS"
	export LDFLAGS="-L$BUILD_PREFIX/lib $LDFLAGS"
fi

cmake -B build $CMAKE_ARGS \
	-DPython3_EXECUTABLE=$PYTHON \
	-DCMAKE_CXX_FLAGS="$CXXFLAGS -D_LIBCPP_DISABLE_AVAILABILITY"
cmake --build build -j$CPU_COUNT
cmake --install build

echo "===== Installed Files ====="
find $PREFIX
echo "===== End of Installed Files ====="
