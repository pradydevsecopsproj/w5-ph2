output "tfstate_bucket_arn" {
  description = "ARN of the Terraform remote state S3 bucket"
  value       = module.s3.tfstate_bucket_arn
}

output "tfstate_bucket_id" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = module.s3.tfstate_bucket_id
}

output "tfstate_bucket_name" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = module.s3.tfstate_bucket_name
}

# output for logging bucket 
output "tfstate_bucket_id_logging" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = module.s3.tfstate_bucket_id_logging
}

output "tfstate_bucket_name_logging" {
  description = "Bucket ID (same as name) for Terraform state"
  value       = module.s3.tfstate_bucket_name_logging
}