#!/bin/bash
#set -x #echo on

#https://tecadmin.net/install-jenkins-in-ubuntu/

#Refreshing package
sudo apt-get update
sudo apt-get -y upgrade

#Install Java
sudo apt-get install default-jdk

#Install Maven
sudo apt-get install maven

#maven version
mvn --version

# Install Jenkins on ubuntu with java 
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

# Install Jenkins on ubuntu with java
sudo apt-get update 
sudo apt-get install jenkins

#Start Jenkins service
sudo service jenkins restart

#the jenkins will be available at port 8080 of the ip.
# then you need to enter the secret password on the first login which can be found via the following command
#sudo less /var/lib/jenkins/secrets/initialAdminPassword

