# Datasources
# Get existing AZ
data "aws_availability_zones" "available" {
  state = "available"
}
# Get existing S3 bucket for remote state -backend 
# data "aws_s3_bucket" "bucket" {
#   state = "available"
# }

# Locals Block
locals {
  azs            = slice(data.aws_availability_zones.available.names, 0, 3)                   // Considering 3 AZ (ap-south-1a, ap-south-1b, ap-south-1c)
  public_subnets = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, k)] // 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24
  # private_subnets = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, k + 10)]

  common_tags = {
    Owner          = "pradyumnakumar.jena@einfochips.com"
    DM             = "Sumeet.Sawant@einfochips.com"
    Department     = "PES"
    "Project Name" = "devops poc"
    "End Date"     = "26-08-2026"
    BU             = "Intelligent Automation"
  }
}
