resource "kubernetes_secret" "grafana" {
  metadata {
    name        = "grafana-admin"
    namespace   = "opencloudcx"
    labels = {
      "ConnectOutput"="true"
    }
  }

  data = {
    username = "admin"
    password = random_password.grafana.result
  }

  type = "kubernetes.io/basic-auth"

  depends_on = [
    module.eks,
    kubernetes_namespace.opencloudcx,
  ]
}