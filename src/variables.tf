variable "aws_region" {
  type        = string
  description = ""
}

variable "instance_ami" {
  type        = string
  description = ""
}

variable "instance_type" {
  type        = string
  description = ""
}

variable "instance_tags" {
  type        = map(string)
  description = ""

  default = {
    Name    = "Primeira Instância"
    Project = "Terraform AWS"
    Env     = "Dev"
  }
}


variable "bucket_name" {
  type        = string
  description = ""
}
