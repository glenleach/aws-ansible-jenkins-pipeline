# The public IP address of the Jenkins server, in CIDR notation.
# This is used to allow SSH access from Jenkins to the Ansible server.
jenkins_server_public_ip = "35.178.125.202/32"

# Your own public IP address, in CIDR notation.
# This allows you (the admin) to SSH into the Ansible server for management.
my_public_IP_address = "86.177.173.149/32"

# The name of the SSH key pair to use for the Ansible server EC2 instance.
# This key must already exist in AWS EC2 Key Pairs.
key_name = "ansible-server-key"
