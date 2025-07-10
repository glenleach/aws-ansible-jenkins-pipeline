resource "aws_instance" "app_server" {
  count         = 2
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (eu-west-2)
  instance_type = "t2.micro"

  tags = {
    Name = "app-server-${count.index + 1}"
  }
}
