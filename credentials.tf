# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

resource "kubernetes_service_account" "dashboard" {
  metadata {
    name      = "k8s-dashboard-admin"
    namespace = "spinnaker"
  }

  depends_on = [helm_release.k8s_dashboard]
}

resource "kubernetes_cluster_role_binding" "dashboard" {
  metadata {
    name = "k8s-dashboard-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "k8s-dashboard-admin"
    namespace = "spinnaker"
  }
}
