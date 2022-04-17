# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

resource "kubernetes_namespace" "spinnaker" {
  metadata {
    name = "spinnaker"
  }
}

resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}


resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "jenkins"
  }
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace" "opencloudcx" {
  metadata {
    name = "opencloudcx"
  }
}

