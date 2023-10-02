resource "aws_instance" "moapp" {
  ami                      = "ami-05377c442727e8308"
  instance_type            = "t3.medium"
  vpc_security_group_ids   = [var.sg]

  tags = {
    Name = "Module-Instance"
  }
}

variable "sg"