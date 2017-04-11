#!/bin/bash
#set -x #echo on

#Refreshing package
sudo yum install epel-release -y

#Install Java
sudo yum install -y java-1.8.0-openjdk

echo `java -version`

#Download hadoop binaries
wget http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz

#Unzip the archive to a designated location
sudo tar -zxvf hadoop-2.7.3.tar.gz -C /opt

#remove the hadoop-env.sh file
sudo rm /opt/hadoop-2.7.3/etc/hadoop/hadoop-env.sh

#Download hadoop-env.sh from github
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/hadoop-env.sh -P /opt/hadoop-2.7.3/etc/hadoop/
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/core-site.xml -P /opt/hadoop-2.7.3/etc/hadoop/
sudo wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/hdfs-site.xml -P /opt/hadoop-2.7.3/etc/hadoop/

#You can add the path of the Hadoop program to the PATH environment variable for your convenience
echo "export PATH=/opt/hadoop-2.7.3/bin:$PATH" | sudo tee -a /etc/profile

#change to sudo
#sudo -s
source /etc/profile

#Setup input files
mkdir ~/source
cp /opt/hadoop-2.7.3/etc/hadoop/*.xml ~/source

#Run hadoop example
hadoop jar /opt/hadoop-2.7.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep ~/source ~/output 'principal[.]*'

#Output result
cat ~/output/*

#ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
ssh -o "StrictHostKeyChecking=no" localhost

echo "Script finished!!"
