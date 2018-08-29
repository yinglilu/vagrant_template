#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing slicer..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/slicer
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

mkdir -p $D_DIR

VERSION=Slicer-4.7.0-2017-09-30-linux-amd64.tar.gz
curl -L --retry 6 https://www.dropbox.com/s/iol36x9oozjdtci/${VERSION}?dl=0 | tar zx -C $D_DIR --strip-components=1

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR/bin" in the PATH already.
else
	
    printf "\n#slicer\n" >>$PROFILE
	echo "export PATH=$D_DIR:\$PATH" >> $PROFILE    
fi

#create init script
echo "PATH=$D_DIR:\$PATH" >> $PROFILE
source $PROFILE

#test installation
Slicer -h >/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PROFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi
