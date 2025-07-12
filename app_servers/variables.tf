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
  description = "AWS availability zone for the instances"
  type        = string
  default     = "eu-west-2a"
}

variable "key_name" {
  description = "Name of the SSH key pair to use for app servers"
  type        = string
}

variable "ansible_server_public_ip_address" {
  description = "Public IP address (in CIDR notation) of the Ansible server allowed to SSH into app servers (e.g., 1.2.3.4/32)"
  type        = string
}
