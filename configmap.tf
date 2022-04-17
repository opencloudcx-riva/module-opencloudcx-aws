# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

locals {
  jenkins_config_script = templatefile("${path.module}/script/jenkins-config.tpl", {
    jenkinsPassword = random_password.jenkins.result
    dns_zone        = local.full_dns_zone
    }
  )
}

resource "kubernetes_config_map" "jenkins_config" {
  metadata {
    namespace = "spinnaker"
    name      = "jenkins-setup-script"
  }
  data = {
    "get-token.sh" = local.jenkins_config_script
  }

  depends_on = [
    kubernetes_namespace.spinnaker,
  ]
}
