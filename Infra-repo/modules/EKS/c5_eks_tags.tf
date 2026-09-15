# -------------------------------------------------------------------
# Public Subnet Tags for EKS Load Balancer Support
# -------------------------------------------------------------------
# For public_elb
resource "aws_ec2_tag" "eks_subnet_tag_public_elb" {
  for_each    = toset(data.terraform_remote_state.vpc.outputs.public_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}
# For public_cluster
resource "aws_ec2_tag" "eks_subnet_tag_public_cluster" {
  for_each    = toset(data.terraform_remote_state.vpc.outputs.public_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${local.eks_cluster_name}"
  value       = "shared"
}

# -------------------------------------------------------------------
# Private Subnet Tags for EKS Internal LoadBalancer Support
# -------------------------------------------------------------------
# # For private_elb
# resource "aws_ec2_tag" "eks_subnet_tag_private_elb" {
#   for_each    = toset(data.terraform_remote_state.vpc.outputs.private_subnet_ids)
#   resource_id = each.value
#   key         = "kubernetes.io/role/internal-elb"
#   value       = "1"
# }
# # For private_cluster
# resource "aws_ec2_tag" "eks_subnet_tag_private_cluster" {
#   for_each    = toset(data.terraform_remote_state.vpc.outputs.private_subnet_ids)
#   resource_id = each.value
#   key         = "kubernetes.io/cluster/${local.eks_cluster_name}"
#   value       = "shared"
# }
