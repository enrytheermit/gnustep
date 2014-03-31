#!/bin/bash

# build gnustep-base
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
cd gnustep/core/base

autoreconf # to apply changes to configure.ac
./configure --host=arm-linux-androideabi \
	--enable-nxconstantstring \
	--disable-invocations \
	--disable-iconv \
	--disable-tls \
	--disable-icu \
	--disable-xml \
	--disable-openssl \
	--with-cross-compilation-info=./cross.config
make -j2
make install
