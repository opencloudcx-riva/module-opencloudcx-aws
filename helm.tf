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
    kubernetes_namespace.cert-manager,
  ]
}

resource "helm_release" "grafana" {
  name             = "grafana"
  chart            = "grafana"
  namespace        = "opencloudcx"
  repository       = var.grafana_helm_repo
  timeout          = var.helm_timeout
  version          = var.grafana_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "admin.existingSecret"
    value = "grafana-admin"
  }

  set {
    name  = "admin.userKey"
    value = "username"
  }

  set {
    name  = "admin.passwordKey"
    value = "password"
  }

  set {
    name  = "plugins[0]"
    value = "grafana-piechart-panel"
  }

  set {
    name  = "plugins[1]"
    value = "grafana-worldmap-panel"
  }

  set {
    name  = "plugins[2]"
    value = "grafana-clock-panel"
  }

  set {
    name  = "plugins[3]"
    value = "grafana-simple-json-datasource"
  }

  set {
    name  = "plugins[4]"
    value = "grafana-googlesheets-datasource"
  }

  set {
    name  = "plugins[5]"
    value = "marcusolsson-csv-datasource"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.opencloudcx,
  ]
}

resource "helm_release" "influxdb" {
  name             = "bitnami"
  chart            = "influxdb"
  namespace        = "opencloudcx"
  repository       = var.influxdb_helm_repo
  timeout          = var.helm_timeout
  version          = var.influxdb_helm_chart_version
  create_namespace = false
  reset_values     = false


  set {
    name  = "database"
    value = "prometheus"
  }

  set {
    name  = "adminUser.name"
    value = "admin"
  }

  set {
    name  = "adminUser.pwd"
    value = random_password.influx_admin.result
  }

  set {
    name  = "user.name"
    value = "prometheus"
  }

  set {
    name  = "user.pwd"
    value = random_password.influx_user.result
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.opencloudcx,
  ]
}

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

  depends_on = [
    module.eks,
    kubernetes_namespace.jenkins,
  ]
}

resource "helm_release" "keycloak" {
  name             = "keycloak"
  chart            = "keycloak"
  namespace        = "spinnaker"
  repository       = var.keycloak_helm_repo
  timeout          = var.helm_timeout
  version          = var.keycloak_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "auth.adminPassword"
    value = random_password.keycloak_admin.result
  }

  set {
    name  = "auth.managementPassword"
    value = random_password.keycloak_user.result
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.spinnaker,
  ]
}

resource "helm_release" "k8s_dashboard" {
  name             = "k8s-dashboard"
  chart            = "kubernetes-dashboard"
  namespace        = "spinnaker"
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
    kubernetes_namespace.spinnaker,
  ]
}

resource "helm_release" "selenium3_grid" {
  name             = "selenium3"
  chart            = "selenium3"
  namespace        = "jenkins"
  repository       = var.selenium_helm_repo
  timeout          = var.helm_timeout
  version          = var.selenium_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "firefox.enabled"
    value = "true"
  }

  set {
    name  = "chrome.enabled"
    value = "true"
  }

  set {
    name  = "hub.serviceType"
    value = "ClusterIP"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.jenkins,
  ]
}

resource "helm_release" "sonarqube" {
  name             = "sonarqube"
  chart            = "sonarqube"
  namespace        = "jenkins"
  repository       = var.sonarqube_helm_repo
  timeout          = var.helm_timeout
  version          = var.sonarqube_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "account.adminPassword"
    value = random_password.sonarqube.result
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.jenkins,
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

resource "helm_release" "prometheus" {
  name             = "prometheus"
  chart            = "prometheus"
  namespace        = "opencloudcx"
  repository       = var.prometheus_helm_repo
  timeout          = var.helm_timeout
  version          = var.prometheus_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "gp2"
  }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "gp2"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.opencloudcx,
  ]

}