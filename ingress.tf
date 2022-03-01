data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  depends_on = [
    helm_release.ingress-controller,
  ]
}

data "kubernetes_service" "k8s_dashboard" {
  metadata {
    name      = "k8s-dashboard-kubernetes-dashboard"
    namespace = "spinnaker"
  }

  depends_on = [
    helm_release.k8s_dashboard,
  ]
}

data "kubernetes_service" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = "spinnaker"
  }

  depends_on = [
    helm_release.keycloak,
  ]
}

resource "kubernetes_ingress" "jenkins_insecure" {

  wait_for_load_balancer = true

  metadata {
    name      = "jenkins-insecure"
    namespace = "jenkins"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {

      host = "jenkins-insecure.${local.full_dns_zone}"

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
  }

  depends_on = [
    helm_release.jenkins,
    helm_release.ingress-controller,
  ]
}

resource "kubernetes_ingress" "jenkins" {

  wait_for_load_balancer = true

  metadata {
    name      = "jenkins-reverse-proxy"
    namespace = "jenkins"
    annotations = {
      "kubernetes.io/ingress.allow-http" = "false"
      "kubernetes.io/ingress.class"      = "nginx"
      "cert-manager.io/cluster-issuer"   = "cert-manager"
    }
  }
  spec {
    rule {

      host = "jenkins.${local.full_dns_zone}"

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

resource "kubernetes_ingress" "spinnaker" {

  wait_for_load_balancer = true

  metadata {
    name      = "spinnaker"
    namespace = "spinnaker"

    annotations = {
      "kubernetes.io/ingress.allow-http" = "false"
      "kubernetes.io/ingress.class"      = "nginx"
      "cert-manager.io/cluster-issuer"   = "cert-manager"
    }
  }
  spec {
    rule {

      host = "spinnaker.${local.full_dns_zone}"

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

resource "kubernetes_ingress" "spinnaker_gate" {

  wait_for_load_balancer = true

  metadata {
    name      = "spinnaker-gate"
    namespace = "spinnaker"

    annotations = {
      "kubernetes.io/ingress.allow-http" = "false"
      "kubernetes.io/ingress.class"      = "nginx"
      "cert-manager.io/cluster-issuer"   = "cert-manager"
    }
  }
  spec {
    rule {

      host = "spinnaker-gate.${local.full_dns_zone}"

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

resource "kubernetes_ingress" "grafana" {

  wait_for_load_balancer = true

  metadata {
    name      = "grafana"
    namespace = "opencloudcx"

    annotations = {
      "kubernetes.io/ingress.allow-http" = "false"
      "kubernetes.io/ingress.class"      = "nginx"
      "cert-manager.io/cluster-issuer"   = "cert-manager"
      # "nginx.ingress.kubernetes.io/certificate-arn" = var.aws_certificate_arn
    }
  }
  spec {
    rule {

      host = "grafana.${local.full_dns_zone}"

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

resource "kubernetes_ingress" "sonarqube" {

  wait_for_load_balancer = true

  metadata {
    name      = "sonarqube"
    namespace = "jenkins"

    annotations = {
      "kubernetes.io/ingress.allow-http" = "false"
      "kubernetes.io/ingress.class"      = "nginx"
      "cert-manager.io/cluster-issuer"   = "cert-manager"
    }
  }
  spec {
    rule {

      host = "sonarqube.${local.full_dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "sonarqube-sonarqube"
            service_port = 9000
          }
        }
      }
    }

    tls {
      secret_name = "sonarqube-tls-secret"
    }
  }

  depends_on = [
    helm_release.sonarqube,
    helm_release.ingress-controller,
  ]
}
