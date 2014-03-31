#!/bin/bash

# fetch gnustep and libobjc2
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
if false ; then
	# fetch all
	echo " ==> FETCHING GNUSTEP"
	svn co http://svn.gna.org/svn/gnustep/modules gnustep
else
	# fetch just gnustep-make, gnustep-base and libobjc2
	mkdir -p gnustep/core
	mkdir -p gnustep/dev-libs
	cd gnustep/core
	echo " ==> FETCHING GNUSTEP MAKE & BASE"
	svn co http://svn.gna.org/svn/gnustep/tools/make/trunk/ make
	svn co http://svn.gna.org/svn/gnustep/libs/base/trunk/ base
	cd ../..
	cd gnustep/dev-libs
	echo " ==> FETCHING LIBOBJC2"
	svn co http://svn.gna.org/svn/gnustep/libs/libobjc2/trunk libobjc2
	cd ../../
fi

