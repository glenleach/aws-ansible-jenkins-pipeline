provider "aws" {
  region = "eu-west-2"
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

resource "aws_instance" "ansible_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.ansible_instance_profile.name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install epel -y
    yum install -y ansible python3 python3-pip
    pip3 install boto boto3
  EOF

  tags = {
    Name = "ansible-ec2-instance"
  }
}
