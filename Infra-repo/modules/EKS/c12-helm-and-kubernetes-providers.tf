# Datasource: EKS Cluster Auth 
# It fetches a temporary Authenticaion Token. This TOKEN will act like a short lived KubeConfig Credential.And it'll refreshed automaticaaly by Terraform.
# The Token is valid for 15 minutes. So, we need to re-run our terraform scripts every 15 minutes to get a new token. 
# In real time, you can use AWS CLI or AWS Console to get this token. 

# data "aws_eks_cluster_auth" "cluster" {
#   name = aws_eks_cluster.main.id
# }

# # HELM Provider
# # This allows Terraform to connect securely to the EKS control-plane and mange HELM releases directly inside the cluster.
# provider "helm" {
#   kubernetes = {
#     host                   = aws_eks_cluster.main.endpoint
#     cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
#     token                  = data.aws_eks_cluster_auth.cluster.token
#   }
# }

# # Terraform Kubernetes Provider -- This step is "optional" unles until we donot required to write k8s resources in "Terraform language"
# # It required to deploy kuberneties reources (like configmap.yaml) written-in "Terrafomr-langualge" (like https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map#example-usage)
# provider "kubernetes" {
#   host = aws_eks_cluster.main.endpoint 
#   cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
#   token = data.aws_eks_cluster_auth.cluster.token
# }


