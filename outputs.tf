output "jenkins_url" {
  value = aws_route53_record.jenkins_cname.name
}

output "sonarqube_url" {
  value = aws_route53_record.sonarqube_cname.name
}

output "dashboard_url" {
  value = aws_route53_record.k8s_dashboard_cname.name
}

output "spinnaker_url" {
  value = aws_route53_record.spinnaker_cname.name
}

output "spinnaker_gate_url" {
  value = aws_route53_record.spinnaker_gate_cname.name
}
