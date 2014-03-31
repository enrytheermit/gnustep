#!/bin/bash

# build gnustep-make
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
cd gnustep/core/make

./configure --host=arm-linux-androideabi
make
make install


