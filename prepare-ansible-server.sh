#!/bin/bash

# Suppress interactive prompts from apt
export DEBIAN_FRONTEND=noninteractive

# Wait for cloud-init and networking to settle (if needed)
sleep 30

# Update package lists with retries
for i in {1..5}; do
  sudo apt-get update -y && break
  sleep 10
done

# Install required packages
sudo apt-get install -y software-properties-common
sudo add-apt-repository universe

# Update again after adding repository
for i in {1..5}; do
  sudo apt-get update -y && break
  sleep 10
done

# Install Ansible and Python dependencies
sudo apt-get install -y ansible python3 python3-pip
sudo pip3 install boto boto3

# Wait to ensure the home directory is ready (optional, for cloud-init environments)
sleep 10

echo "Ansible server preparation complete."
