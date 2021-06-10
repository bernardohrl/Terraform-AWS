terraform {
  required_version = "1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}