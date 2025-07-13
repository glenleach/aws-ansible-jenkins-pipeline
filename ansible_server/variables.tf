variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "availability_zone" {
  description = "AWS availability zone for the instance"
  type        = string
  default     = "eu-west-2a"
}

variable "my_public_IP_address" {
  description = "Your public IP address in CIDR notation (e.g., 1.2.3.4/32)"
  type        = string
}

variable "jenkins_server_public_ip" {
  description = "Public IP address of the Jenkins server in CIDR notation (e.g., 1.2.3.4/32)"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the Ansible server EC2 instance"
  type        = string
}
