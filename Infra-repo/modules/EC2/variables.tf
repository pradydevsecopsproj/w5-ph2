variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Existing subnet ID inside the VPC"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "instance_name" {
  description = "EC2 instance Name tag"
  type        = string
  default     = "app-server-prady"
}

variable "environment_name" {
  description = "Environment name"
  type        = string
  default     = "production"
}

# variable "ssh_allowed_cidr" {
#   description = "CIDR allowed to connect to SSH"
#   type        = string
# }