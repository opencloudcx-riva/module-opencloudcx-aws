locals {
  jenkins_jcasc_script = templatefile("${path.module}/script/jenkins-JCasC-jenkins.tpl", {
    # dns_zone        = local.full_dns_zone
    }
  )
}

resource "helm_release" "jenkins" {
  name             = "jenkins"
  chart            = "jenkins"
  namespace        = "jenkins"
  repository       = var.jenkins_helm_repo
  timeout          = var.helm_timeout
  version          = var.jenkins_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "controller.adminUser"
    value = "admin"
  }

  set {
    name  = "controller.adminPassword"
    value = random_password.jenkins.result
  }

  set {
    name  = "controller.installLatestSpecifiedPlugins"
    value = "true"
  }

  set {
    name  = "controller.numExecutors"
    value = "1"
  }

  set {
    name  = "controller.tag"
    value = "2.309-jdk11"
  }

  set {
    name  = "controller.installPlugins[0]"
    value = "kubernetes:1.29.4"
  }

  set {
    name  = "controller.installPlugins[1]"
    value = "workflow-aggregator:2.6"
  }

  set {
    name  = "controller.installPlugins[2]"
    value = "docker-build-step:2.8"
  }

  set {
    name  = "controller.installPlugins[3]"
    value = "workflow-cps-global-lib:2.21"
  }

  set {
    name  = "controller.installPlugins[4]"
    value = "pipeline-model-extensions:1.9.3"
  }

  set {
    name  = "controller.installPlugins[5]"
    value = "junit:1.52"
  }

  set {
    name  = "controller.installPlugins[6]"
    value = "matrix-project:1.19"
  }

  set {
    name  = "controller.installPlugins[7]"
    value = "lockable-resources:2.11"
  }

  set {
    name  = "controller.installPlugins[8]"
    value = "pipeline-rest-api:2.19"
  }

  set {
    name  = "controller.installPlugins[9]"
    value = "workflow-cps:2.93"
  }

  set {
    name  = "controller.installPlugins[10]"
    value = "ws-cleanup:0.39"
  }

  set {
    name  = "controller.installPlugins[11]"
    value = "docker-workflow:1.26"
  }

  set {
    name  = "controller.installPlugins[12]"
    value = "docker-commons:1.17"
  }

  set {
    name  = "controller.installPlugins[13]"
    value = "configuration-as-code:1.54"
  }

  set {
    name  = "controller.installPlugins[14]"
    value = "git:4.7.1"
  }

  set {
    name  = "controller.JCasC.enabled"
    value = "true"
  }

  set {
    name  = "controller.JCasC.configScripts.jenkins"
    value = local.jenkins_jcasc_script
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.jenkins,
  ]
}
