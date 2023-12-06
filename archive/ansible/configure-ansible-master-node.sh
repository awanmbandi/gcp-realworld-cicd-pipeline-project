#!/bin/bash
## Install Ansible Controller
sudo yum install ansible -y
ansible --version

## Configure Ansible Client Node Environment
sudo useradd ansible
sudo sh -c 'echo ansible:ansibleadmin | chpasswd'
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i "s/.*#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
sudo service sshd restart
sudo su
echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

## Install Tomcat
yum install tomcat -y
systemctl enable tomcat
systemctl start tomcat
systemctl status tomcat

## Wget
yum install wget -y
