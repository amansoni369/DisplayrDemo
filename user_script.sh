#! /bin/bash

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart
sudo echo -e "temp_password\ntemp_password" | passwd ubuntu

sudo apt-get update -y
sudo apt-get install nginx -y