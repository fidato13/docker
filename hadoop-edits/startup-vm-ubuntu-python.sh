#!/bin/bash
#set -x #echo on

#execute this script inside vm using below command:
#wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/startup-vm-ubuntu-python.sh;chmod 777 startup-vm-ubuntu-python.sh;echo "Y Y Y" | source ./startup-vm-ubuntu-python.sh

#Refreshing package
sudo apt-get update
sudo apt-get -y upgrade

#Install Java
sudo apt-get install default-jdk

#python is pre-installed on ubuntu
python3 -V

#To manage software packages for Python, let’s install pip:
sudo apt-get install -y python3-pip

# some packages
sudo apt-get install build-essential libssl-dev libffi-dev python-dev

#Install Maven
sudo apt-get install maven

#Install eclipse on ubuntu:
wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/3/eclipse-java-neon-3-linux-gtk-x86_64.tar.gz
tar -xvf eclipse-java-neon-3-linux-gtk-x86_64.tar.gz

#run eclipse
~/eclipse/eclipse