#!/bin/bash

# build libobjc2
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
cd gnustep/dev-libs/libobjc2

rm -rf build
mkdir -p build && cd build
#cmake -DCMAKE_TOOLCHAIN_FILE="${ANDROID_GNUSTEP_INSTALL_ROOT}/android.toolchain.cmake" -DCOMPILER_FAMILY=clang -DCOMPILER_FAMILY_PP=clang++ ..
cmake -DCMAKE_TOOLCHAIN_FILE="${ANDROID_GNUSTEP_INSTALL_ROOT}/android.toolchain.cmake" -DLLVM_ANDROID_TOOLCHAIN_DIR="/tmp/my-android-toolchain/" -DTESTS=FALSE ..
make -j8 objc objcxx
make install

