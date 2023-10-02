resource "aws_instance" "web" {
  ami           = "ami-05377c442727e8308"
  instance_type = "t3.medium"

  tags = {
    Name = "My-Tf-Instance"
  }
}

output "private_ip_address" {
  value   = aws_instance.web.*.private_dns
}

# Creating security group

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}