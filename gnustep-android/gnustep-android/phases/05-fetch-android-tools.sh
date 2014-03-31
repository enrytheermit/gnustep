#!/bin/bash

# fetch android tools
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
echo " ==> FETCHING ANDROID TOOLS"
if [ ! -e android-sdk_r21.1-linux.tgz ] ; then
	wget http://dl.google.com/android/android-sdk_r21.1-linux.tgz
else
	echo "Already downloaded. (If downloaded partially, please remove relevant tgz.)"
fi

if [ ! -e android-sdk_r21.1-linux.tgz ] ; then
	echo "Failed to download. Aborting."
	exit 1
fi

################
echo " ==> UNPACKING ANDROID TOOLS"
if [ ! -e android-sdk-linux ] ; then
	tar xfz android-sdk_r21.1-linux.tgz
else
	echo "Already unpacked."
fi

if [ ! -e android-sdk-linux ] ; then
	echo "Failed to unpack. Aborting."
	exit 1
fi

