#!/bin/bash
set -e
# Run Ensure s3 bucket created through "00-S3_bucket_remote_backend" and updated the bucket detail in belo files. Then execute this script file to work 
# \Infra-repo\03_Terraform_EKS_Cluster\01_VPC_terraform-manifests\c1-versions.tf
# \Infra-repo\03_Terraform_EKS_Cluster\02_EKS_terraform-manifests\c1_versions.tf
# \Infra-repo\03_Terraform_EKS_Cluster\02_EKS_terraform-manifests\c3_remote-state.tf

echo "==============================="
echo "STEP-1: Create VPC using Terraform"
echo "==============================="
cd 01_VPC_terraform-manifests
terraform init 
terraform validate
terraform plan -out=out-vpc
terraform apply out-vpc
# terraform apply -auto-approve

echo
echo "==============================="
echo "STEP-2: Create EKS Cluster using Terraform"
echo "==============================="
cd ../02_EKS_terraform-manifests
terraform init 
terraform validate
terraform plan -out=out-eks
terraform apply out-eks
# terraform apply -auto-approve

echo
echo "✅ EKS Cluster and VPC creation completed successfully!"
