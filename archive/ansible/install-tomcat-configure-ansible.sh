#!/bin/bash
## Install Ansible 
sudo yum install ansible -y
ansible --version

## Configure Ansible friendly environment
sudo useradd ansible
sudo sh -c 'echo ansible:ansibleadmin | chpasswd'
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i "s/.*#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
sudo service sshd restart
sudo echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

## Install Tomcat
sudo yum install tomcat -y
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo systemctl status tomcat

## Wget
sudo yum install wget -y
