locals {
  bucket_name = "${random_pet.bucket.id}-${var.environment}"

  test_filename = "TestFile.json"
}


resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  acl    = "private"

  tags = {
    Service     = "Curso Terraform"
    Environment = var.environment
  }
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = "arn:aws:s3:::${local.bucket_name}/*"
        Condition = {
          IpAddress = { "aws:SourceIp" = "8.8.8.8/32" }
        }
      },
    ]
  })
}


resource "aws_s3_bucket_object" "object1" {
  bucket = aws_s3_bucket.this.id

  # Nome que será apresentado no bucket
  key = local.test_filename

  # Caminho local do arquivo
  source = "./files/${local.test_filename}"

  # Tipo do Arquivo
  content_type = "application/json"

  # Identifica quanto o conteúdo do arquivo foi alterado para poder subir novamente
  etag = filemd5("./files/${local.test_filename}")
}


resource "aws_s3_bucket_object" "object2" {
  bucket = aws_s3_bucket.this.id

  key          = "${random_pet.bucket.id}.json"
  source       = "./files/${local.test_filename}"
  content_type = "application/json"

  etag = filemd5("./files/${local.test_filename}")
}

resource "aws_s3_bucket" "manual" {
  bucket = "bucket-criado-por-mim"

  tags = {
    Managed_By = "Terraform"
  }
}