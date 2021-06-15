terraform {
  required_version = "1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-013479601834"
    key    = "dev/01-usando-remote-state/terraform.tstate"
    region = "sa-east-1"
  }
}


provider "aws" {
  region = var.aws_region
}