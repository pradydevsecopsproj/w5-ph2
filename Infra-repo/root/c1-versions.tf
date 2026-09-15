terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  # Remote Backend
  backend "s3" {
    bucket       = "tfstate-dev-root-ap-south-1-dv7swa-main-bkt" # Need to update bucket detail from "00-S3_bucket_remote_backend"
    key          = "vpc/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}