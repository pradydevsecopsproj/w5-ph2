module "vpc" {
  source           = "../modules/vpc"
  environment_name = var.environment_name
  vpc_cidr         = var.vpc_cidr
  subnet_newbits   = var.subnet_newbits
  tags             = var.tags
}

#-------Chekc if any way create resource creation dependecy
# module "SG" {
#   source           = "../modules/SG"   
# }
# module "EC2" {
#   source           = "../modules/EC2"
#   subnet_id = var.subnet_id
#   environment_name = var.environment_name
#   instance_type = var.instance_type
#   vpc_id =  module.vpc.vpc_id
#   key_name = var.key_name   
# }

# /*module "EKS" {
  
# }*/