#!/bin/bash
#set -x #echo on

#Refreshing package
sudo apt-get update

#execute this script inside vm using below command:
#wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/startup-vm-ubuntu-single-node-pseudo-mode.sh;chmod 777 startup-vm-ubuntu-single-node-pseudo-mode.sh; source ./startup-vm-ubuntu-single-node-pseudo-mode.sh

#Install Java
sudo apt-get install default-jdk

echo `java -version`

#Download hadoop binaries
wget http://apache.mirrors.tds.net/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz

#Unzip the archive to a designated location
sudo tar -zxvf hadoop-2.7.3.tar.gz -C /opt

#remove the hadoop-env.sh file
sudo rm /opt/hadoop-2.7.3/etc/hadoop/hadoop-env.sh
sudo rm /opt/hadoop-2.7.3/etc/hadoop/core-site.xml
sudo rm /opt/hadoop-2.7.3/etc/hadoop/hdfs-site.xml
sudo rm /opt/hadoop-2.7.3/etc/hadoop/yarn-site.xml
sudo rm /opt/hadoop-2.7.3/etc/hadoop/mapred-site.xml.template

#Download hadoop-env.sh from github
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/hadoop-env.sh -P /opt/hadoop-2.7.3/etc/hadoop/
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/core-site.xml -P /opt/hadoop-2.7.3/etc/hadoop/
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/hdfs-site.xml -P /opt/hadoop-2.7.3/etc/hadoop/
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/yarn-site.xml -P /opt/hadoop-2.7.3/etc/hadoop/
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/mapred-site.xml -P /opt/hadoop-2.7.3/etc/hadoop/

#amend the path
export PATH=/opt/hadoop-2.7.3/bin:$PATH
export PATH=/opt/hadoop-2.7.3/sbin:$PATH

#ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
ssh -o "StrictHostKeyChecking=no" localhost 'exit'

#
sudo chmod -R 777 /opt/

#Namenode Format
hdfs namenode -format

echo "Namenode formatted!!"

#start dfs
start-dfs.sh

echo "HDFS daemon started!"

#start-yarn
start-yarn.sh

echo "YARN daemon started!"

#create hdfs directory
#hdfs dfs -mkdir -p /user/trn

#Copy the input files into the distributed filesystem
#hdfs dfs -put /opt/hadoop-2.7.3/etc/hadoop input

#Run some of the examples provided
#hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep input output 'dfs[a-z.]+'

#Copy the output files from the distributed filesystem to the local filesystem and examine them
#bin/hdfs dfs -get output output
#cat output/*

echo "Go to http://<ip_address>:50070/ - for Namenode & hdfs UI"
echo "Go to http://<ip_address>:8088/ - for ResourceManager"
