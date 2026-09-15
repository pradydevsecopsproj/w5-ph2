variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Name      = "pradyumna_poc"
  }
}

variable "subnet_newbits" {
  description = "Number of new bits to add to VPC CIDR to generate subnets (e.g., 8 means /24 from /16)"
  type        = number
  default     = 8
}

# # SSH ingress should atleast use My IP
# variable "myip" {
#   description = "my ip address"
#   type        = string
#   default     = "103.150.139.211"
# }

# variable "subnet_id" {
#   description = "Existing subnet ID inside the VPC"
#   type        = string
# }
# variable "key_name" {
#   description = "Existing EC2 key pair name"
#   type        = string
# }
# variable "instance_type" {
#   description = "EC2 instance type"
#   type        = string
#   default     = "t2.micro"
# }