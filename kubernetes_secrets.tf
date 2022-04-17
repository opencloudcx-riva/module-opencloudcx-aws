# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

resource "kubernetes_secret" "grafana" {
  metadata {
    name      = "grafana-admin"
    namespace = "opencloudcx"
    labels = {
      "ConnectOutput" = "true"
    }
  }

  data = {
    username = "admin"
    password = random_password.grafana.result
  }

  type = "kubernetes.io/basic-auth"

  depends_on = [
    kubernetes_namespace.opencloudcx,
  ]
}

resource "kubernetes_secret" "dockerhub" {
  metadata {
    name      = var.kubernetes_dockerhub_secret_name
    namespace = "jenkins"
  }

  data = {

    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.kubernetes_dockerhub_secret_repository_url}" = {
          auth = "${base64encode("${var.kubernetes_secret_dockerhub_username}:${var.kubernetes_secret_dockerhub_password}")}"
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"

  depends_on = [
    kubernetes_namespace.opencloudcx,
  ]
}

resource "kubernetes_secret" "sonarqube" {
  metadata {
    name      = "sonarqube-admin"
    namespace = "jenkins"
    labels = {
      "ConnectOutput" = "true"
    }
  }

  data = {
    username = "admin"
    password = random_password.sonarqube.result
  }

  type = "kubernetes.io/basic-auth"

  depends_on = [
    kubernetes_namespace.jenkins,
  ]
}

