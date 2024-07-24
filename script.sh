#!/bin/bash

# Update and install required packages
sudo yum update -y

# Install Git
sudo yum install git -y

# Install required packages
sudo yum install -y yum-utils lvm2

# Install Docker CE
sudo yum install -y docker

# Start Docker service
sudo service docker start

# Enable service to start on boot
sudo systemctl enable docker

# Verify that Docker is running
sudo systemctl status docker

# Add ec2-user to the docker group so you can execute Docker commands without using sudo
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo yum install -y curl
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Print Docker and Docker Compose versions
echo "Docker installed version:"
docker --version
echo "Docker Compose installed version:"
docker-compose --version
