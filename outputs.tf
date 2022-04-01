output "aws_eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "aws_eks_cluster_auth_token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "aws_eks_cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}

output "aws_eks_cluster" {
  value = data.aws_eks_cluster.cluster
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "grafana_secret" {
  value = random_password.grafana.result
}

output "jenkins_secret" {
  value = random_password.jenkins.result
}

output "sonarqube_secret" {
  value = random_password.sonarqube.result
}

output "jenkins_url" {
  value = "jenkins-insecure.${local.full_dns_zone}"
}

output "spinnaker_gate_url" {
  value = "spinnaker-gate.${local.full_dns_zone}"
}

# output "sonarqube_key" {
#   value = sonarqube_webhook.webhook.id
# }