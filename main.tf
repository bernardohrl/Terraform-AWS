terraform {
  required_version = "1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }
}


provider "aws" {
  region = "sa-east-1"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "bernardohrls-bucket-1"
  acl    = "private"

  tags = {
    name        = "Benardohrls bucket"
    Environment = "Dev"
    Owner       = "Bernardohrl"
  }
}