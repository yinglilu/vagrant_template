#!/bin/bash

#note: need install anaconda first

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "..."
	exit 0
fi

#install afni
wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated afni

#install fsl
wget -O- http://neuro.debian.net/lists/trusty.de-md.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
sudo apt-get update
sudo apt-get install -y fsl #this will install atalas too

#test installation
echo "testing afni install"
afni --help > /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

echo "testing fsl install"
fsl5.0-bet2 -h > /dev/null  #fsl5.0-fsl -h always show a gui, use fsl5.0-bet2 instead.
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi
