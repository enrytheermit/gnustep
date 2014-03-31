#!/bin/bash

# wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20130219.zip
# apt-get install unzip

. $(dirname $BASH_SOURCE)/env.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/00-dependencies-ubuntu.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/05-fetch-android-tools.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/06-fetch-android-sdk.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/10-fetch-android-ndk.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/11-ndk-environment.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/12-ndk-compiler-environment.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/15-bootstrap-standalone-ndk-toolchain.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/20-fetch-gnustep-and-libobjc2.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/25-fetch-android-cmake-toolchain-file.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/30-build-libobjc2.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/35-update-gnustep-make-for-androideabi.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/36-build-gnustep-make.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/40-source-gnustep-sh.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/45-patch-gnustep-base.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/46-build-gnustep-base.sh

