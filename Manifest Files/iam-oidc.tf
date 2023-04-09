data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "oidc_provider" {

  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = [var.eks_oidc_root_ca_thumbprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}


# Extract OIDC Provider from OIDC Provider ARN
locals {
    aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}


## out put the values so you can refer it 

output "cliet_id_dns" {
  value = data.aws_partition.current.dns_suffix
}

output "openid_url" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "OIDC_Provider" {
  value = local.aws_iam_oidc_connect_provider_extract_from_arn
}

