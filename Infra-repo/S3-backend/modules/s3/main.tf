# Help in creating unique name using random string generator
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# 2 Bucket creation
# one for remote state storage
# one for server access logging. S3 general purpose buckets should have server access logging enabled  --Maharshi recommended 

resource "aws_s3_bucket" "this" {
  for_each = {
    tfstate_bucket_main = "main-bkt"
    log_bucket          = "logging-bkt"
  }
  bucket = "tfstate-${var.environment_name}-${var.aws_region}-${random_string.suffix.result}-${each.value}" // best practice

  force_destroy = true # avoid using for production enviroments
  lifecycle {
    prevent_destroy = false # For production may have to make TRUE
  }
  tags = merge(local.common_tags, { Name = "pradyjulyminproj01" })
}

# Versioning enabled
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.this["tfstate_bucket_main"].id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption enebled
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  for_each = aws_s3_bucket.this // Applies to both above buckets
  bucket   = each.value.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Public access restriction
resource "aws_s3_bucket_public_access_block" "tfstate_block_public" {
  for_each = aws_s3_bucket.this // Applies to both above buckets
  bucket   = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 general purpose buckets should have Lifecycle configurations --Maharshi recommended
resource "aws_s3_bucket_lifecycle_configuration" "demo" {
  for_each = aws_s3_bucket.this // Applies to both above buckets
  bucket   = each.value.id

  rule {
    id     = "cleanup-old-files-prady"
    status = "Enabled"

    filter {
      prefix = "" # Applies to all object belong to the bucket
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7 # S3 automatically deletes any multipart uploads that have not completed within seven days.
    }
  }
}

# S3 general purpose buckets should require requests to use SSL -- --Maharshi recommended
resource "aws_s3_bucket_policy" "ssl_only" {
  bucket = aws_s3_bucket.this["tfstate_bucket_main"].id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.this["tfstate_bucket_main"].arn,
          "${aws_s3_bucket.this["tfstate_bucket_main"].arn}/*"
        ]

        Condition = {
          Bool = {
            "aws:SecureTransport" = "false" // for all HTTP requests --Prady
          }
        }
      }
    ]
  })
}


# Logging Configuration
resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.this["tfstate_bucket_main"].id

  target_bucket = aws_s3_bucket.this["log_bucket"].id

  target_prefix = "access-logs/"
}

# Allow S3 to Write Logs 
resource "aws_s3_bucket_policy" "log_bucket_policy" {
  bucket = aws_s3_bucket.this["log_bucket"].id
  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid = "AllowS3ServerAccessLogs"

        Effect = "Allow"

        Principal = {
          Service = "logging.s3.amazonaws.com"
        }

        Action = "s3:PutObject"

        Resource = "${aws_s3_bucket.this["log_bucket"].arn}/access-logs/*"
      }
    ]
  })
}