#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo "installing anaconda3"

#install dep
sudo apt-get update >/dev/null
sudo apt-get install -y bzip2 >/dev/null

DEST=$1/anaconda3
if [ -d $DEST ]; then
	rm -rf $DEST
fi

mkdir -p $DEST

INST_FILE=Anaconda3-5.2.0-Linux-x86_64.sh
#-P: prefix, where there file will be save to
wget -q -P $DEST --tries=10 https://repo.continuum.io/archive/$INST_FILE 
#-b:bacth mode, -f: no error if install prefix already exists
bash $DEST/$INST_FILE -b -f -p $DEST >/dev/null
rm $DEST/$INST_FILE

#add PATH
echo "export PATH=$DEST/bin:\$PATH" >/etc/profile.d/anaconda3.sh

#test installation
echo "test anaconda install: "
source /etc/profile.d/anaconda3.sh
conda update conda -y > /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
	echo "To update PATH of current terminal: source /etc/profile.d/anaconda3.sh"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi
