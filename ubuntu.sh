#!/bin/bash

# Update and upgrade the system
echo "Updating system..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the Docker repository
echo "Setting up Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
echo "Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y docker-ce

# Start Docker and enable it to start at boot
echo "Starting Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Add the current user to the Docker group (optional)
echo "Adding user to Docker group..."
sudo usermod -aG docker $USER

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d '"' -f 4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Set executable permissions for Docker Compose binary
echo "Setting executable permissions for Docker Compose..."
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
docker-compose --version

# Final message
echo "Docker and Docker Compose installation complete!"
