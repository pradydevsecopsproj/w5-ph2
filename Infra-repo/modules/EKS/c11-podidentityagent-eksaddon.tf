# Datasource: To get "default" EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "pia_default" {
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.main.version
}

# Datasource: To get "latest" EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "pia_latest" {
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.main.version
  most_recent        = true
}

# EKS Addon: Pod Identity Agent -- For demo pupose used pubilc nodes
resource "aws_eks_addon" "podidentity" {
  depends_on = [aws_eks_node_group.public_nodes]   // Since PIA ds has to run in a Node in NodeGroup, it ensures the NodeGroup is healthy and up-n-running
  cluster_name                = aws_eks_cluster.main.id
  addon_name                  = "eks-pod-identity-agent" // Ensure the value as it is since its not a custom name
  # Below 2 lines tells Terraform, If there any older/conflicting configuation, then just replace with this latest one  
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  # Use the latest EKS addon version compatible with the cluster's Kubernetes version
  addon_version               = data.aws_eks_addon_version.pia_latest.version 
}


# Outputs
output "pod_identity_agent_eksaddon_default_version" {
  value = data.aws_eks_addon_version.pia_default.version
}

output "pod_identity_agent_eksaddon_lastest_version" {
  value = data.aws_eks_addon_version.pia_latest.version
}
output "pod_identity_agent_eksaddon_arn" {
  value = aws_eks_addon.podidentity.arn
}  

output "pod_identity_agent_eksaddon_id" {
  value = aws_eks_addon.podidentity.id
}
