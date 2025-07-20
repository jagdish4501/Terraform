resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraformstateyabx" # Replace with a unique name
  force_destroy = false
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    id     = "prevent-destroy"
    status = "Enabled"
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}


