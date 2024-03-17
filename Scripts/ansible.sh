#!/bin/bash

# Add ppa for Ansible
sudo apt-add-repository -y ppa:ansible/ansible

# Update apt
sudo apt update

# Install ansible
sudo apt install -y ansible