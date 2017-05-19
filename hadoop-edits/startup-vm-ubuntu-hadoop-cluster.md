#!/bin/bash
#set -x #echo on

#https://dwbi.org/etl/bigdata/183-setup-hadoop-cluster

# Imp , when datanode process on datanodes doesn't start
#cd /usr/local/hadoop_work
#rm -rf *
#chown fido:fido -R /usr/local/hadoop_work
#chmod 777 -R /usr/local/hadoop_work

#Refreshing package
sudo apt-get update

#execute this script inside vm using below command:
#wget https://raw.githubusercontent.com/fidato13/docker/master/hadoop-edits/startup-vm-ubuntu-single-node-pseudo-mode.sh;chmod 777 startup-vm-ubuntu-single-node-pseudo-mode.sh; source ./startup-vm-ubuntu-single-node-pseudo-mode.sh

#Install Java
sudo apt-get install default-jdk

echo `java -version`

#Download hadoop binaries
wget http://apache.mirrors.tds.net/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz

#mkdir hadoop
sudo mkdir /usr/local/hadoop

#Unzip the archive to a designated location
sudo tar -zxvf hadoop-2.7.3.tar.gz -C /usr/local/hadoop --strip 1 >> /dev/null

#mkdir hadoop data
sudo mkdir -p /usr/local/hadoop_work/hdfs/namenode
sudo mkdir -p /usr/local/hadoop_work/hdfs/namesecondary

#find java home using:
#(readlink -f /usr/bin/java | sed "s:bin/java::")

#Paste below lines in .bashrc

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PATH=$PATH:$JAVA_HOME/bin
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
export CLASSPATH=$CLASSPATH:/usr/local/hadoop/lib/*:.

export HADOOP_OPTS="$HADOOP_OPTS -Djava.security.egd=file:/dev/../dev/urandom"

# source .bashrc
source ~/.bashrc

#Setup JAVA_HOME under hadoop environment
vi /usr/local/hadoop/etc/hadoop/hadoop-env.sh

#inside the file 
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")



# Everytime we need to change the ip of slaves/datanodes in the file of hadoop clusters , since the ip of the vms will change everytime:
#in the node-1, go to vi /etc/hosts
10.0.1.195      node-1
10.0.1.196      node-2
10.0.1.197      node-3
10.0.1.198      node-4



rm -rf /usr/local/hadoop_work/hdfs/datanode/*

Below is the sequence of commands/steps to be run on namenode whenever vms are rebooted or moved in to another networks i.e. their ip addresses change:
1. Format the namenode:
```
hdfs namenode -format
```
2. log into datanodes, and delete all the hdfs data on datanodes by using the following commands:
```
rm -rf /usr/local/hadoop_work/hdfs/datanode/*
```
3. start hdfs services:
```
start-dfs.sh
```
4. Create useful hdfs directories for yarn:
```
hadoop fs -mkdir /tmp;
hadoop fs -chmod -R 1777 /tmp;
hadoop fs -mkdir /user;
hadoop fs -chmod -R 1777 /user;
hadoop fs -mkdir /user/app;
hadoop fs -chmod -R 1777 /user/app;
hadoop fs -mkdir -p /var/log/hadoop-yarn;
hadoop fs -chmod -R 1777 /var/log/hadoop-yarn;
hadoop fs -mkdir -p /var/log/hadoop-yarn/apps;
hadoop fs -chmod -R 1777 /var/log/hadoop-yarn/apps;
```
5. check the created directories:
```
hdfs dfs -lsr /
```
6. verify that datanodes are connected, first by executing command 'jps' on every datanode and 
then running the following command on your namenode:
```
hdfs dfsadmin -report 
```
7. start yarn:
```
start-yarn.sh
```

Congratulations , your cluster is now up and running!!
