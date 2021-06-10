resource "aws_instance" "web" {
  ami           = "ami-07bfd9965e7b972d1"
  instance_type = "t3.micro"

  tags = {
    Name = "First Instance"
    Env  = var.environment
  }
}