# DevOps Bootcamp Demo: Automated AWS Ansible Server, EC2 App Servers with Load Balancer, and Jenkins-Driven Nginx Deployment

## Overview
**Project Update:**
- The project now targets only specific app-server instances within a region (using tags/filters), rather than all instances.
- The Nginx application is deployed behind an AWS Application Load Balancer for high availability and scalability.

This project provisions an Ansible server and EC2 app servers behind an Application Load Balancer, then uses Jenkins to deploy an Ansible playbook that installs Docker and runs a simple Nginx application on each app server.

The project demonstrates the following:
- Automated provisioning of AWS infrastructure using Terraform
- Configuration management and application deployment using Ansible
- CI/CD pipeline integration with Jenkins
- Running a Dockerized Nginx application on AWS EC2 instances managed by an Auto Scaling Group and behind an Application Load Balancer

## Getting Started

To clone this repository, run:

```sh
git clone https://github.com/glenleach/aws-ansible-jenkins-pipeline
cd <your-repo-name>
```

## Prerequisites

- **Manually create two AWS EC2 key pairs:**
  - One key pair for the Ansible server (e.g., `ansible-server-key`)
  - One key pair for the app servers (e.g., `ec2-app-server-key`)
- Download and keep the private keys safe. You will reference these key names in your `terraform.tfvars` files.

## Example terraform.tfvars Files

**app_servers/terraform.tfvars**
```hcl
# Name of the SSH key pair to use for the app server EC2 instances (must exist in AWS)
key_name = "ec2-app-server-key"

# The public IP address of the Ansible server, in CIDR notation (e.g., 1.2.3.4/32)
ansible_server_public_ip_address = "203.0.113.10/32"
```

**ansible_server/terraform.tfvars**
```hcl
# Name of the SSH key pair to use for the Ansible server EC2 instance (must exist in AWS)
key_name = "ansible-server-key"

# The public IP address of the Jenkins server, in CIDR notation (e.g., 1.2.3.4/32)
jenkins_server_public_ip = "203.0.113.20/32"

# Your own public IP address, in CIDR notation (for admin SSH access)
my_public_IP_address = "198.51.100.5/32"
```

Copy these examples to your own `terraform.tfvars` files and update the values for your environment.

## Step-by-Step Instructions

### 1. Set up the Ansible Server
- Go to the `ansible_server` directory.
- Edit `terraform.tfvars` and set the following variables:
  ```hcl
  key_name = "<your-ansible-server-key>"
  jenkins_server_public_ip = "<your-jenkins-public-ip>/32"
  my_public_IP_address = "<your-own-public-ip>/32"
  ```
- Run:
  ```sh
  terraform init
  terraform apply
  ```
- Note the public IP of the Ansible server from the Terraform output.

### 2. Set up the App Servers
- Go to the `app_servers` directory.
- Edit `terraform.tfvars` and set the following variables:
  ```hcl
  key_name = "<your-ec2-app-server-key>"
  ansible_server_public_ip_address = "<ansible-server-public-ip>/32"
  ```
- Run:
  ```sh
  terraform init
  terraform apply
  ```
- Note the public IPs of the app servers from the AWS console or Terraform output.

### 3. Configure Jenkins
- Set up a Jenkins server (can be on your local machine or in the cloud).
- **Ensure the following Jenkins plugins are installed:**
  - SSH Agent
  - SSH Pipeline Steps
- Add SSH credentials for both the Ansible server and app servers.
- Configure the Jenkins pipeline using the provided `Jenkinsfile`.
- Ensure Jenkins can SSH into the Ansible server using the correct key.

**Before running the pipeline, ensure that the Jenkinsfile has the correct public IP address for the Ansible server. After adjusting all entries, push your changes to your remote repository and then run your pipeline.**

### 4. Run the Jenkins Pipeline
- Trigger the Jenkins pipeline.
- The pipeline will:
  - Copy Ansible playbooks and inventory to the Ansible server
  - Copy the app server SSH key to the Ansible server
  - Run the Ansible playbook to install Docker and deploy Nginx on each app server

### 5. Verify the Deployment
- Access the public IP of any app server in your browser to see the Nginx welcome page.
- Access the Application Load Balancer DNS name (from Terraform output) to verify load-balanced access to Nginx.

## Purpose
This project is designed for educational purposes only, to help students learn and practice real-world DevOps workflows and tools in a cloud environment.

License

Copyright © Techworld with Nana. All rights reserved.

This project is provided for personal training and educational purposes only. No part of this project may be reproduced, distributed, or transmitted in any form or by any means, including photocopying, recording, or other electronic or mechanical methods, without the prior written permission of the copyright owner, except in the case of brief quotations embodied in critical reviews and certain other noncommercial uses permitted by copyright law
