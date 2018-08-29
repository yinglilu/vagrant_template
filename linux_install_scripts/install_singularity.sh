#!/bin/bash

# singularity version#
VERSION=2.5.2

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install_to_folder(absolute path)>"
	echo "For sudoer recommend: $0 /opt (recommend)"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo "installing singularity"

#install dep:
sudo apt-get update >/dev/null
sudo apt-get install -y \
    python \
    dh-autoreconf \
    build-essential \
    libarchive-dev >/dev/null

#remove older version 
S_DIR=$1/singularity
if [ -d $S_DIR ]; then
	rm -rf $S_DIR
fi

mkdir -p $1

pushd /tmp
wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=$S_DIR
make >/dev/null
make install >/dev/null
make clean >/dev/null
popd

# add PATH
echo "export PATH=$S_DIR/bin:\$PATH" > /etc/profile.d/singularity.sh
echo "export LD_LIBRARY_PATH=$S_DIR/lib/singularity:\$LD_LIBRARY_PATH" >> /etc/profile.d/singularity.sh


#test installation
source /etc/profile.d/singularity.sh
singularity -h

echo "NOTE: run 'source /etc/profile.d/singularity.sh' to update PATH."
