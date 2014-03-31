#!/bin/bash

# bootstrap a standalone toolchain
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
rm -rf /tmp/my-android-toolchain
${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh --platform=android-14 --install-dir=/tmp/my-android-toolchain --toolchain=arm-linux-androideabi-clang3.1
export PATH=/tmp/my-android-toolchain/bin:$PATH

