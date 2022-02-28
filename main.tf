provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  }
}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}

# tags
locals {
  suffix             = random_string.scope.result
  artifact-repo-name = join("-", compact(["artifact", var.stack, local.suffix]))
  region             = var.region
  name               = format("%s-%s", var.name, var.stack)
  cluster_version    = var.cluster_version

  name-tag               = { "Name" = local.name }
  db-name-tag            = { "Name" = join("-", compact([local.name, "db"])) }
  vpc-name-tag           = { "Name" = join("-", compact([local.name, "vpc"])) }
  igw-name-tag           = { "Name" = join("-", compact([local.name, "igw"])) }
  ngw-name-tag           = { "Name" = join("-", compact([local.name, "ngw"])) }
  public-route-name-tag  = { "Name" = join("-", compact([local.name, "public-route"])) }
  private-route-name-tag = { "Name" = join("-", compact([local.name, "private-route"])) }
  private-dns-name-tag   = { "Name" = join("-", compact([local.name, "private-dns"])) }

  full_dns_zone = format("%s.%s", var.stack, var.dns_zone)

  # kubernetes tags
  vpc-k8s-shared-tag = {
    format("kubernetes.io/cluster/%s", local.name) = "shared"
  }
  vpc-k8s-owned-tag = {
    "key"                 = format("kubernetes.io/cluster/%s", local.name)
    "value"               = "owned"
    "propagate_at_launch" = "true"
  }
}

resource "random_string" "scope" {
  length  = 8
  upper   = false
  number  = false
  special = false
}

