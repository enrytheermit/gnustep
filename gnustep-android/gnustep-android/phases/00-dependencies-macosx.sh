#!/bin/bash

PWDDIR=`pwd`
BUILDDIR=${PWDDIR%%}/build
PATH=$PATH:$BUILDDIR/bin

gnustepandroid_has_package()
{
	HASPACKAGE=`$1 --version`
	if [[ $? != 127 ]] ; then
		HASPACKAGE=`echo $HASPACKAGE | cut -d ' ' -f 3`
		return 0
	fi
	if [[ $? != 0 ]] ; then
		return 1
	fi
	HASPACKAGE=`echo $HASPACKAGE | cut -d ' ' -f 3`
	if [ $HASPACKAGE == 'installed' ] ; then
		return 0
	else
		echo $HASPACKAGE
	fi
	return 1
	
}

### This should all be installed
# we need build-essential for Make et al
# add-apt-repository is in python-software-properties
# android needs sun java
# gnustep needs svn
	
if [[ ! -f build ]] ; then
	mkdir build
fi

# libobjc2 needs cmake


if ! gnustepandroid_has_package cmake; then

	echo "Not installed...downloading"
	cd build
	wget http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz
	tar xzf cmake-2.8.12.2.tar.gz
	cd cmake-2.8.12.2
	./configure --prefix=$BUILDDIR
	make
	make install
	cd ..
	### FIXME g++ ?	
	export CMAKE_CXX_COMPILER=gcc
	export CMAKE_CC_COMPILER=gcc
else
	echo "cmake : Already installed"
fi
echo

