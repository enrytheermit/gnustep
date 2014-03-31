#!/bin/bash

# fetch android sdk
cd "${ANDROID_GNUSTEP_INSTALL_ROOT}"
echo " ==> FETCHING ANDROID SDK"
cd android-sdk-linux/tools
if false ; then
	# fetch everything
	./android update sdk -u
else
	# try to fetch just newest platform sdk
	export NEWEST_API=$(./android list sdk -a | grep "SDK Platform Android" | head -n 1 | sed 's/.*API \(.\+\),.*/\1/')
	if [ ! -e ../platforms/android-$NEWEST_API ] ; then
		./android update sdk -u --filter platform-tools,android-${NEWEST_API}
	else
		echo "Already fetched. "
	fi
	
	if [ ! -e ../platforms/android-$NEWEST_API ] ; then
		echo "Failed to fetch android sdk"
		exit 1
	fi
fi

