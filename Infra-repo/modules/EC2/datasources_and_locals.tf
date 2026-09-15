# --------------------------------------------------------------------
# Local values used throughout the EC2 configuration
# Helps enforce naming consistency and reduce duplication
# --------------------------------------------------------------------
locals {
  # Environment name such as dev, staging, prod (from variable)
  environment = var.environment_name # Example: "dev"

  common_tags = {
    Owner          = "pradyumnakumar.jena@einfochips.com"
    DM             = "Sumeet.Sawant@einfochips.com"
    Department     = "PES"
    "Project Name" = "devops poc"
    "End Date"     = "26-08-2026"
    BU             = "Intelligent Automation"
  }
}
