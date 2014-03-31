#!/bin/bash

# update gnustep-make's config.sub to recognize androideabi
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
cd gnustep/core/make

rm config.sub
wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD" -O config.sub

