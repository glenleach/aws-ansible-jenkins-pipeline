provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_role" "ansible_role" {
  name = "ansible-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ansible_ec2_policy" {
  role       = aws_iam_role.ansible_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_instance_profile" "ansible_instance_profile" {
  name = "ansible-ec2-instance-profile"
  role = aws_iam_role.ansible_role.name
}

resource "aws_security_group" "ansible_ssh" {
  name        = "ansible-ssh-sg"
  description = "Allow SSH access to Ansible server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.jenkins_server_public_ip, var.my_public_IP_address]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ansible_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # Use a stable key_name if needed, or remove if not required
  vpc_security_group_ids = [aws_security_group.ansible_ssh.id]
  subnet_id     = tolist(data.aws_subnets.default.ids)[0]

  iam_instance_profile = aws_iam_instance_profile.ansible_instance_profile.name

  key_name  = var.key_name
  user_data = templatefile("${path.module}/user_data.sh", {})

  tags = {
    Name = "ansible-ec2-instance"
  }
}



output "ansible_server_public_ip" {
  value = aws_instance.ansible_ec2.public_ip
}
