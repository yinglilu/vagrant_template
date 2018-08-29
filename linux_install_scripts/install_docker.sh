#!/bin/bash

#remove older version
sudo apt-get remove -y docker docker-engine docker.io

sudo apt-get update

#offical method
#sudo apt-get install -y docker-ce

#other method
wget -q -O-  https://get.docker.com/ |sh

sudo usermod -aG docker $USER

# test
sudo docker run hello-world

#echo 'Must:log out and then log in'
#echo 'use "docker run hello-world" to test it.'
