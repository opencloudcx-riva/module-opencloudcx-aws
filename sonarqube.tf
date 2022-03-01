terraform {
  required_providers {
    sonarqube = {
      source = "jdamata/sonarqube"
    }
  }
}

provider "sonarqube" {
    user   = "admin"
    pass   = random_password.sonarqube.result 
    host   = "https://sonarqube.${local.full_dns_zone}"
}

resource "sonarqube_webhook" "webhook" {
  name = "jenkins-webhook"
  url  = "http://jenkins.jenkins.svc.cluster.local:8080/sonarqube-webhook/"
}