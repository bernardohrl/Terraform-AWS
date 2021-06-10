output "bucket_name" {
    value = aws_s3_bucket.this.id
}

output "bucket_arn" {
    value = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
    value = aws_s3_bucket.this.bucket_domain_name
}

output "test_file_name" {
    value = "${aws_s3_bucket.this.id}/${aws_s3_bucket_object.object1.key}"
}