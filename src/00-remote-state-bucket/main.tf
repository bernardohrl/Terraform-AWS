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
  region = var.aws_region
}


data "aws_caller_identity" "current" {}


resource "aws_s3_bucket" "remote-state" {
  bucket = "tfstate-${data.aws_caller_identity.current.id}"

  versioning {
    enabled = true
  }

  tags = {
    Description = "Stores terraform remote state files"
    ManagedBy   = "Terraform"
    Owner       = "Bernardo Henrique"
    CreatedAt   = "2021-06-15"
  }
}


output "remote_state_bucket" {
  value = aws_s3_bucket.remote-state.bucket
}
output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote-state.arn
}