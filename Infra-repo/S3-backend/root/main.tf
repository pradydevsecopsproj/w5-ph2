
# Invoking s3 module 
module "s3" {
  source           = "../modules/s3"
  environment_name = var.environment_name
}
