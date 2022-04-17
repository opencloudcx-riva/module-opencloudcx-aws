# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

data "aws_route53_zone" "zone" {
  name = local.full_dns_zone
}

resource "aws_route53_record" "jenkins_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "jenkins.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.jenkins,
  ]
}

resource "aws_route53_record" "jenkins_insecure_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "jenkins-insecure.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.jenkins,
  ]
}

resource "aws_route53_record" "k8s_dashboard_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "dashboard.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.k8s_dashboard.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.k8s_dashboard,
  ]
}

resource "aws_route53_record" "keycloak_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "keycloak.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.keycloak.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.keycloak,
  ]
}

resource "aws_route53_record" "grafana_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "grafana.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.grafana,
  ]
}

resource "aws_route53_record" "spinnaker_gate_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "spinnaker-gate.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.spinnaker
  ]
}

resource "aws_route53_record" "spinnaker_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "spinnaker.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.spinnaker,
  ]
}

resource "aws_route53_record" "sonarqube_cname" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "sonarqube.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.sonarqube
  ]
}

