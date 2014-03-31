#!/bin/bash

# fetch android-cmake toolchain file
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
if false ; then
	# not used; no clang support
	wget http://android-cmake.googlecode.com/hg/toolchain/android.toolchain.cmake
else
	# source: http://root.cern.ch/svn/root/trunk/interpreter/llvm/src/cmake/platforms/Android.cmake
	# modified to replace CMAKE_C_COMPILER's reference to CMAKE_BINARY_DIR with LLVM_ANDROID_TOOLCHAIN_DIR
	# also, changed sysroot
	cat > android.toolchain.cmake << _EOF
	# Toolchain config for Android NDK.
	# This is expected to be used with a standalone Android toolchain (see
	# docs/STANDALONE-TOOLCHAIN.html in the NDK on how to get one).
	#
	# Usage:
	# mkdir build; cd build
	# cmake ..; make
	# mkdir android; cd android
	# cmake -DLLVM_ANDROID_TOOLCHAIN_DIR=/path/to/android/ndk \
	#   -DCMAKE_TOOLCHAIN_FILE=../../cmake/platforms/Android.cmake ../..
	# make <target>

	SET(CMAKE_SYSTEM_NAME Linux)
	SET(CMAKE_C_COMPILER \${LLVM_ANDROID_TOOLCHAIN_DIR}/bin/clang)
	SET(CMAKE_CXX_COMPILER \${LLVM_ANDROID_TOOLCHAIN_DIR}/bin/clang++)
	SET(ANDROID "1" CACHE STRING "ANDROID" FORCE)

	SET(ANDROID_COMMON_FLAGS "-target arm-linux-androideabi -B\${LLVM_ANDROID_TOOLCHAIN_DIR}") # -mllvm -arm-enable-ehabi")
	SET(CMAKE_C_FLAGS "\${ANDROID_COMMON_FLAGS}" CACHE STRING "toolchain_cflags" FORCE)
	SET(CMAKE_CXX_FLAGS "\${ANDROID_COMMON_FLAGS}" CACHE STRING "toolchain_cxxflags" FORCE)
	SET(CMAKE_LINK_FLAGS "\${ANDROID_COMMON_FLAGS}" CACHE STRING "toolchain_linkflags" FORCE)
_EOF
fi

