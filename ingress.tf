data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  depends_on = [
    helm_release.ingress-controller,
  ]
}

data "kubernetes_service" "k8s_dashboard_ingress" {
  metadata {
    name      = "k8s-dashboard-kubernetes-dashboard"
    namespace = "dashboard"
  }

  depends_on = [
    helm_release.k8s_dashboard,
  ]
}

data "kubernetes_service" "keycloak_ingress" {
  metadata {
    name      = "keycloak"
    namespace = "spinnaker"
  }

  depends_on = [
    helm_release.keycloak,
  ]
}

resource "kubernetes_ingress" "jenkins_ingress" {

  wait_for_load_balancer = true

  metadata {
    name      = "jenkins-reverse-proxy"
    namespace = "jenkins"
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "cert-manager"
    }
  }
  spec {
    rule {

      host = "jenkins.${var.dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "jenkins"
            service_port = 8080
          }
        }
      }
    }

    tls {
      secret_name = "jenkins-tls-secret"
    }
  }

  depends_on = [
    helm_release.jenkins,
    helm_release.ingress-controller,
  ]
}

resource "kubernetes_ingress" "spinnaker_ingress" {

  wait_for_load_balancer = true

  metadata {
    name      = "spinnaker"
    namespace = "spinnaker"

    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "cert-manager"
    }
  }
  spec {
    rule {

      host = "spinnaker.${var.dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "spin-deck"
            service_port = 9000
          }
        }
      }
    }

    tls {
      secret_name = "spinnaker-tls-secret"
    }
  }

  depends_on = [
    helm_release.spinnaker,
    helm_release.ingress-controller,
  ]
}

resource "kubernetes_ingress" "spinnaker_gate__ingress" {

  wait_for_load_balancer = true

  metadata {
    name      = "spinnaker-gate"
    namespace = "spinnaker"

    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "cert-manager"
    }
  }
  spec {
    rule {

      host = "spinnaker-gate.${var.dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "spin-gate"
            service_port = 8084
          }
        }
      }
    }

    tls {
      secret_name = "spinnaker-tls-secret"
    }
  }

  depends_on = [
    helm_release.spinnaker,
    helm_release.ingress-controller,
  ]
}

resource "kubernetes_ingress" "grafana_ingress" {

  wait_for_load_balancer = true

  metadata {
    name      = "grafana"
    namespace = "opencloudcx"

    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "cert-manager"
    }
  }
  spec {
    rule {

      host = "grafana.${var.dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "grafana"
            service_port = 3000
          }
        }
      }
    }

    tls {
      secret_name = "grafana-tls-secret"
    }
  }

  depends_on = [
    helm_release.grafana,
    helm_release.ingress-controller,
  ]
}

resource "kubernetes_ingress" "selenium3__ingress" {

  wait_for_load_balancer = true

  metadata {
    name      = "selenium3-grid"
    namespace = "jenkins"

    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "cert-manager"
    }
  }
  spec {
    rule {

      host = "selenium.${var.dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "selenium3-selenium-hub"
            service_port = 4444
          }
        }
      }
    }

    tls {
      secret_name = "selenium3-tls-secret"
    }
  }

  depends_on = [
    helm_release.selenium3_grid,
    helm_release.ingress-controller,
  ]
}

