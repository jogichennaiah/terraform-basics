resource "aws_instance" "web" {
  ami           = "ami-05377c442727e8308"
  instance_type = "t3.medium"

  tags = {
    Name = "My-Tf-Instance"
  }
}