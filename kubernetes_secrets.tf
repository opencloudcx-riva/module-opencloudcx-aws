resource "kubernetes_secret" "grafana_secret" {
  metadata {
    name        = "grafana-admin"
    namespace   = "opencloudcx"
    labels = {
      "ConnectOutput"="true"
    }
  }

  data = {
    username = "admin"
    password = random_password.grafana_password.result
  }

  type = "kubernetes.io/basic-auth"

  depends_on = [
    module.eks,
    kubernetes_namespace.opencloudcx,
  ]
}