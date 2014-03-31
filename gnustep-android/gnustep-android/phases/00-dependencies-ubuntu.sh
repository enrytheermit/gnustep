#!/bin/bash

gnustepandroid_has_package()
{
	HASPACKAGE=`dpkg-query -W -f='${Status} ${Version}\n' $1`
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

# we need build-essential for Make et al
echo " ==> INSTALLING BUILD-ESSENTIAL"
if ! gnustepandroid_has_package build-essential ; then
	sudo apt-get install build-essential
else
	echo "Already installed"
fi
echo

# add-apt-repository is in python-software-properties
echo " ==> INSTALLING PYTHON-SOFTWARE-PROPERTIES"
if ! gnustepandroid_has_package python-software-properties ; then
	sudo apt-get install python-software-properties
else
	echo "Already installed"
fi
echo

# android needs sun java
echo " ==> INSTALLING ORACLE JAVA"
if false ; then
	sudo add-apt-repository "deb http://archive.canonical.com/ precise partner"
	sudo apt-get update
	sudo apt-get install sun-java6-jdk
else
	if ! gnustepandroid_has_package oracle-java6-installer; then
		sudo add-apt-repository ppa:webupd8team/java
		sudo apt-get update
		sudo apt-get install oracle-java6-installer
	else
		echo "Already installed"
	fi
fi
echo

# gnustep needs svn
echo " ==> INSTALLING SUBVERSION"
if ! gnustepandroid_has_package subversion; then
	sudo apt-get install subversion
else
	echo "Already installed"
fi
echo

# libobjc2 needs cmake
if ! gnustepandroid_has_package cmake; then
	sudo apt-get install cmake
else
	echo "Already installed"
fi
echo

