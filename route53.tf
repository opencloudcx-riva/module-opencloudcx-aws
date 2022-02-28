data "aws_route53_zone" "vpc" {
  name = var.dns_zone
}

resource "aws_route53_zone" "sub_domain" {
  name = local.full_dns_zone

  tags = {
    stack = var.stack
  }
}

resource "aws_route53_record" "ns" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = local.full_dns_zone
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.sub_domain.name_servers
}

# resource "aws_route53_record" "mgmt-cert" {
#   zone_id = aws_route53_zone.sub_domain.zone_id
#   name    = var.aws_certificate_cname
#   type    = "CNAME"
#   ttl     = "300"
#   records = [var.aws_certificate_cname_value]

#   depends_on = [
#     aws_route53_zone.sub_domain
#   ]
# }

resource "aws_route53_record" "jenkins_cname" {
  zone_id = aws_route53_zone.sub_domain.zone_id
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
  zone_id = aws_route53_zone.sub_domain.zone_id
  name    = "jenkins-insecure.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.jenkins,
  ]
}

# resource "aws_route53_record" "sonarqube_insecure_cname" {
#   zone_id = aws_route53_zone.sub_domain.zone_id
#   name    = "sonarqube-insecure.${local.full_dns_zone}"
#   type    = "CNAME"
#   ttl     = "300"
#   records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

#   depends_on = [
#     helm_release.ingress-controller,
#     helm_release.sonarqube,
#   ]
# }

resource "aws_route53_record" "k8s_dashboard_cname" {
  zone_id = aws_route53_zone.sub_domain.zone_id
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
  zone_id = aws_route53_zone.sub_domain.zone_id
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
  zone_id = aws_route53_zone.sub_domain.zone_id
  name    = "grafana.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.grafana,
  ]
}

# resource "aws_route53_record" "selenium_cname" {
#   zone_id = aws_route53_zone.sub_domain.zone_id
#   name    = "selenium.${local.full_dns_zone}"
#   type    = "CNAME"
#   ttl     = "300"
#   records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

#   depends_on = [
#     helm_release.ingress-controller,
#     helm_release.selenium3_grid
#   ]
# }

resource "aws_route53_record" "spinnaker_gate_cname" {
  zone_id = aws_route53_zone.sub_domain.zone_id
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
  zone_id = aws_route53_zone.sub_domain.zone_id
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
  zone_id = aws_route53_zone.sub_domain.zone_id
  name    = "sonarqube.${local.full_dns_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname]

  depends_on = [
    helm_release.ingress-controller,
    helm_release.sonarqube
  ]
}

