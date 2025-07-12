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

variable "jenkins_public_key" {
  description = "Public SSH key for Jenkins to access the Ansible server"
  type        = string
}