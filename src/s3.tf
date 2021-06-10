resource "aws_s3_bucket" "my-bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = "Teste"
  }
}

resource "aws_s3_bucket_policy" "my-bucket" {
  bucket = aws_s3_bucket.my-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = "arn:aws:s3:::${var.bucket_name}/*"
        Condition = {
          IpAddress = { "aws:SourceIp" = "8.8.8.8/32" }
        }
      },
    ]
  })
}