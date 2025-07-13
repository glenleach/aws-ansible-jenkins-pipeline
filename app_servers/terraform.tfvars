# The name of the SSH key pair to use for the app server EC2 instances.
# This key must already exist in AWS EC2 Key Pairs.
key_name = "ec2-app-server-key"

# The public IP address of the Ansible server, in CIDR notation.
# This allows the Ansible server to SSH into the app servers for configuration and management.
ansible_server_public_ip_address = "13.42.51.224/32"
