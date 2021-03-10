provider "aws" {
  region = "sa-east-1"
}


resource "aws_vpc" "private-network" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "production"
   }
}



resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.private-network.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}



resource "aws_instance" "my-first-server" {
  ami           = "ami-0bd91caaa9bc42cf3"
  instance_type = "t2.micro"
  tags = {
    Name = "ubuntu"
    version = "0.01"
  }
}