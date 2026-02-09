resource "aws_s3_bucket" "this" {
  bucket = "${var.project_identifier}-bucket-codepipeline"

  tags = {
    Name = "${var.project_identifier}-bucket-codepipeline"
  }
}

# resource "aws_s3_bucket_versioning" "assets_versioning" {
#   bucket = aws_s3_bucket.assets.id
#   versioning_configuration {
#     status = "Disabled"
#   }
# }

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


