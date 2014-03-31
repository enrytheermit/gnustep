#!/bin/bash

# fetch android ndk
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
echo " ==> FETCHING ANDROID NDK"
if [ ! -e android-ndk-r9d-darwin-x86.tar.bz2 ] ; then
	wget http://dl.google.com/android/ndk/android-ndk-r9d-darwin-x86.tar.bz2
else
	echo "Already downloaded. Skipping."
fi

if [ ! -e android-ndk-r9d-darwin-x86.tar.bz2 ] ; then
	echo "Failed to download. Aborting."
	exit 1
fi

###
echo " ==> UNPACKING ANDROID NDK"
if [ ! -e android-ndk-r9d ] ; then
	tar xfj android-ndk-r9d-darwin-x86.tar.bz2
else
	echo "Already unpacked. Skipping."
fi

if [ ! -e android-ndk-r8d ] ; then
	echo "Failed to unpack. Aborting."
	exit 1
fi


