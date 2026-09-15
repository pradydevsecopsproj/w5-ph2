output "tfstate_bucket_arn" {
  description = "ARN of the Terraform remote state S3 bucket"
  value       = aws_s3_bucket.this["tfstate_bucket_main"].arn
}

output "tfstate_bucket_id" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = aws_s3_bucket.this["tfstate_bucket_main"].id
}

output "tfstate_bucket_name" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = aws_s3_bucket.this["tfstate_bucket_main"].bucket
}

# output for logging bucket 
output "tfstate_bucket_id_logging" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = aws_s3_bucket.this["log_bucket"].id
}

output "tfstate_bucket_name_logging" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = aws_s3_bucket.this["log_bucket"].bucket
}