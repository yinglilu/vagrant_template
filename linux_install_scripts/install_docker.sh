#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: sudo $0 \$USER"
    exit 1
fi

echo "installing docker"

#remove older version
sudo apt-get remove -y docker docker-engine docker.io

sudo apt-get update >/dev/null

#offical method
#sudo apt-get install -y docker-ce

#other method
wget -q -O-  https://get.docker.com/ |sh


sudo usermod -aG docker $1

# fix error: Temporary failure resolving 'security.ubuntu.com'
if [ "$2" = "-uwo" ]; then
   echo {"dns": ["129.100.254.134", "129.100.254.135"]} >/etc/docker/daemon.json
fi

# test
sudo docker run hello-world
