# # Developed by RIVA Solutions Inc 2022.  Authorized Use Only

terraform {
  required_providers {
    kubernetes = {}
    helm       = {}
  }
}

# terraform {
#   required_providers {
#     aws = "~> 3.74"
#   }
# }

# provider "aws" {
#   region     = var.aws_region
#   access_key = var.access_key
#   secret_key = var.secret_key
# }

# provider "kubernetes" {
#   host                   = var.kubernetes_cluster_endpoint
#   token                  = var.kubernetes_auth_token
#   cluster_ca_certificate = var.kubernetes_cluster_ca_certificate
# }

# provider "helm" {
#   kubernetes {
#     host                   = var.kubernetes_cluster_endpoint
#     token                  = var.kubernetes_auth_token
#     cluster_ca_certificate = var.kubernetes_cluster_ca_certificate
#   }
# }

locals {
  full_dns_zone = format("%s.%s", var.stack, var.dns_zone)
  artifact-repo-name = join("-", compact(["artifact", var.stack, local.suffix]))
}