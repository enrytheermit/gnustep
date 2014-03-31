#!/bin/bash

cd build
echo -n "Downloading NDK r9d..."
wget http://dl.google.com/android/ndk/android-ndk-r9d-darwin-x86.tar.bz2
echo "Done."
echo "It's in the build directory, please install it."

###export ANDROID_NDK="${ANDROID_GNUSTEP_INSTALL_ROOT}/android-ndk-r8d"
###export ANDROID_NDK_LLVM="${ANDROID_GNUSTEP_INSTALL_ROOT}/android-ndk-r8d/toolchains/llvm-3.1/prebuilt/linux-x86/bin/"
