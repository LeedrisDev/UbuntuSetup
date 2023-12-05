#!/bin/sh

# Script to install docker and compose

# Update apt
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add docker repository to APT sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt
sudo apt-get update

# Install docker
sudo apt-get install -y docker-ce

# Execute docker without sudo
sudo usermod -aG docker $USER

# Add aliases to .zshrc
echo "
# Docker Compose Aliases

alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'" >> ~/.zshrc

# Apply new group membership
su - $USER