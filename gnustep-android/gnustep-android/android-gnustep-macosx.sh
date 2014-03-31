#!/bin/bash

### We don't use macports
### Install wget before running this script
### This is clean bash, no other return values for example 
### Tested on Snow Leopard

. $(dirname $BASH_SOURCE)/env.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/00-dependencies-macosx.sh

#. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/05-fetch-android-tools.sh
#. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/06-fetch-android-sdk.sh
#. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/10-fetch-android-ndk.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/11-ndk-environment-macosx.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/12-ndk-compiler-environment-macosx.sh

### eabi target not done
#. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/15-bootstrap-standalone-ndk-toolchain.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/20-fetch-gnustep-and-libobjc2-macosx.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/25-fetch-android-cmake-toolchain-file-macosx.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/30-build-libobjc2-macosx.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/35-update-gnustep-make-for-androideabi-macosx.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/36-build-gnustep-make-macosx.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/40-source-gnustep-sh.sh

. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/45-patch-gnustep-base.sh
. ${ANDROID_GNUSTEP_SCRIPT_ROOT}/phases/46-build-gnustep-base.sh

