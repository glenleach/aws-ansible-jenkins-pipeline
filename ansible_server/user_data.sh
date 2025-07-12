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
