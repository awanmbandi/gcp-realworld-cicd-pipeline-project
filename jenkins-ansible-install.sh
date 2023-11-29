#!/bin/bash
## VM Instaructions
# Image: Ubuntu 22.04
# Instance type: 2CPU and 4 or 8+RAM

## Update the packages to their latest versions available after a fresh install of Ubuntu 22.04
sudo apt-get update -y && sudo apt-get upgrade -y
## install Java OpenJDK 11
sudo apt install openjdk-11-jdk -y
## check the installed Java version
java --version
## add the Jenkins repository and Key since they are not added by default in Ubuntu 22.04
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
## Update the system and install Jenkins
sudo apt update -y
sudo apt install jenkins -y
## Once installed, start and enable the Jenkins service
sudo systemctl start jenkins && sudo systemctl enable jenkins
## To check the status of the service
sudo systemctl status jenkins
## Install git
sudo apt install git -y

## Ansible Installation
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y

