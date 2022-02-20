#!/bin/bash
#this script is idempotent. Its ok to run it multiple times while troubleshooting any errors
echo "watch the screen carefully for any errors"
sudo apt install apt-transport-https ca-certificates curl software-properties-common  gpg-agent -y  # 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -    # GPG key for the offi
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"    # 
sudo apt update -y #update the package database with the Docker packages from the newly added repo:
apt-cache policy docker-ce #Make sure you are about to install from the Docker repo instead of the def
sudo apt install docker-ce  -y #Finally, install Docker
sudo systemctl enable docker    # enabled to start on boot
sudo systemctl restart docker   # restart docker once
sudo systemctl status docker    # enabled to start on boot
echo -e "\n\n"
echo "make sure Docker service is in running state"
echo "checking docker version.." ; sleep 2
echo "check docker version"
sudo docker --version
echo "create my-httpd-files"
sudo mkdir my-httpd-files
echo "create index.html"
echo "<h1>this container create by jakeer</h1>" >> /root/my-httpd-files/index.html
echo "creating container"
sudo docker run -d -p 5555:80 -v /root/my-httpd-files:/usr/local/apache2/htdocs --name jakeer-apache1 httpd
sudo docker run -d -p 7777:80 -v /root/my-httpd-files:/usr/local/apache2/htdocs --name jakeer-apache2 httpd
sudo docker run -d -p 8888:80 -v /root/my-httpd-files:/usr/local/apache2/htdocs --name jakeer-apache3 httpd
sudo curl -I localhost:8888
echo "containers launching completed"
