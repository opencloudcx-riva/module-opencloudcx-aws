resource "helm_release" "ingress-controller" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = var.ingress_helm_repo
  timeout          = var.helm_timeout
  create_namespace = false
  reset_values     = false

  set {
    name  = "controller.ingressClassResource.name"
    value = "insecure"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.ingress-nginx
  ]
}

resource "helm_release" "spinnaker" {
  name             = "spinnaker"
  chart            = "spinnaker"
  namespace        = "spinnaker"
  repository       = var.spinnaker_helm_repo
  timeout          = var.helm_timeout
  version          = var.spinnaker_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "halyard.additionalScripts.enabled"
    value = "true"
  }

  set {
    name  = "halyard.additionalScripts.configMapName"
    value = "jenkins-setup-script"
  }

  set {
    name  = "halyard.additionalScripts.configMapKey"
    value = "get-token.sh"
  }

  set {
    name  = "halyard.spinnakerVersion"
    value = "1.19.12"
  }

  set {
    name  = "global.spinDeck.protocol"
    value = "https"
  }

  set {
    name  = "installOpenLdap"
    value = "true"
  }

  set {
    name  = "ldap.enabled"
    value = "true"
  }

  set {
    name  = "ldap.url"
    value = "ldap://-openldap:389"
  }

  set {
    name  = "sapor.config.spinnaker.authnEnabled"
    value = "true"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.spinnaker,
  ]
}

resource "helm_release" "k8s_dashboard" {
  name             = "k8s-dashboard"
  chart            = "kubernetes-dashboard"
  namespace        = "dashboard"
  repository       = var.k8s_dashboard_helm_repo
  timeout          = var.helm_timeout
  version          = var.k8s_dashboard_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "settings.itemsPerPage"
    value = 30
  }

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "settings.clusterName"
    value = "OpenCloudCX"
    #value = "OpenCloudCX [stack:${var.stack}]"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.dashboard,
  ]
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
    value = random_password.jenkins_password.result
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

  depends_on = [
    module.eks,
    kubernetes_namespace.jenkins,
  ]
}

resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  repository       = var.cert_manager_helm_repo
  timeout          = var.helm_timeout
  create_namespace = false
  reset_values     = false

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.dashboard,
  ]
}
