provider "aws" {
  region = "sa-east-1"
}


# VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "production"
  }
}


# Gateway
resource "aws_internet_gateway" "main-gateway" {
  vpc_id = aws_vpc.prod-vpc.id
}


# Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id =  aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_internet_gateway.main-gateway.id
  }

  tags = {
    Name = "Prod"
  }
}


# Subnet
resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone_id = "sa-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}


# Associa Subnet à Route Table
resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.subnet-1.id 
  route_table_id = aws_route_table.prod-route-table.id
}


# Cria secutity group para permitir portas 22, 80 e 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_trafic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_Web"
  }
}


# Interface com um IP na subnet que foi criada
resource "aws_network_interface" "web-service-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}




# Ips elásticos são acessados publicamente
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web-service-nic.id
  associate_with_private_ip = "10.0.0.10"
}
