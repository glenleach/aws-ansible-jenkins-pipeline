#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sleep 120
for i in {1..5}; do
  sudo apt-get update -y && break
  sleep 10
done
sudo apt-get install -y software-properties-common
sudo add-apt-repository universe
for i in {1..5}; do
  sudo apt-get update -y && break
  sleep 10
done
sudo apt-get install -y ansible python3 python3-pip
sudo pip3 install boto boto3

# Wait to ensure the home directory is ready
sleep 30

# Write the private key for Ansible SSH (base64 decoded) to root
mkdir -p /root/.ssh
echo "${private_key_b64}" | base64 -d > /root/.ssh/id_rsa
chown root:root /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
