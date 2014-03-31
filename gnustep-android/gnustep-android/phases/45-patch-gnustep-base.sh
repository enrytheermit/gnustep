#!/bin/bash

# patch gnustep-base
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
cd gnustep/core/base

#patch -p1 < ${ANDROID_GNUSTEP_SCRIPT_ROOT}/patches/00-emmanuel-gsbase_configure_ac.patch
#patch -p1 < ${ANDROID_GNUSTEP_SCRIPT_ROOT}/patches/01-ivucica-gsbase-timezone-daylight.patch
#patch -p1 < ${ANDROID_GNUSTEP_SCRIPT_ROOT}/patches/02-ivucica-gsbase-objc-load-force_dladdr_branch.patch
patch -p1 < ${ANDROID_GNUSTEP_SCRIPT_ROOT}/patches/03-ivucica-gsbase-disabling_openssl.patch
patch -p1 < ${ANDROID_GNUSTEP_SCRIPT_ROOT}/patches/04-ivucica-gsbase-sysinfo_syscall.patch

# tell gnustep-base that we DO have an objc2 runtime
svn revert cross.config
echo "cross_objc2_runtime=1" >> cross.config

