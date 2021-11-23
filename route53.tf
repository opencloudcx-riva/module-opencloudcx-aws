data "aws_route53_zone" "vpc" {
  name = var.dns_zone
}

resource "aws_route53_record" "jenkins_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "jenkins.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.jenkins,
  ]
}

resource "aws_route53_record" "jenkins_insecure_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "jenkins-insecure.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.jenkins,
  ]
}

resource "aws_route53_record" "k8s_dashboard_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "dashboard.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.k8s_dashboard_ingress.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.k8s_dashboard,
  ]
}

resource "aws_route53_record" "keycloak_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "keycloak.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.keycloak_ingress.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.keycloak,
  ]
}

resource "aws_route53_record" "grafana_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "grafana.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.grafana,
  ]
}

resource "aws_route53_record" "selenium_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "selenium.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.selenium3_grid
  ]
}

resource "aws_route53_record" "spinnaker_gate_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "spinnaker-gate.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.spinnaker
  ]
}

resource "aws_route53_record" "spinnaker_cname" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = "spinnaker.${var.dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.spinnaker,
  ]
}
