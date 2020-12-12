#!/bin/bash
cd "$(dirname "$0")"
echo "Installing main components."
dnf install curl -y > /dev/null 2>&1
dnf install -y https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.4.3-3.1.el8.x86_64.rpm > /dev/null 2>&1
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
dnf install -y docker-ce --nobest > /dev/null 2>&1
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1
chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose > /dev/null 2>&1
systemctl start docker.service > /dev/null 2>&1
systemctl enable docker.service > /dev/null 2>&1
echo "Installing docker images."
docker-compose up -d > /dev/null
echo "Installation complete. ELK stack could take a few of minutes to initialize, but your nginx should be up and running."