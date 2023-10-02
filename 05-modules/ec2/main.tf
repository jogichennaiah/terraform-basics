resource "aws_instance" "web" {
  ami                      = "ami-05377c442727e8308"
  instance_type            = "t3.medium"
  vpc_security_group_ids   = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "My-Tf-Instance"
  }
}