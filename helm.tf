# # Developed by RIVA Solutions Inc 2022.  Authorized Use Only

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
    kubernetes_namespace.cert-manager,
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
    kubernetes_namespace.ingress-nginx
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
    helm_release.ingress-controller,
    kubernetes_namespace.spinnaker,
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
    helm_release.ingress-controller,
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
    kubernetes_namespace.opencloudcx,
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
    helm_release.ingress-controller,
    kubernetes_namespace.spinnaker,
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
    helm_release.ingress-controller,
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
    helm_release.ingress-controller,
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
    helm_release.ingress-controller,
    kubernetes_namespace.opencloudcx,
  ]
}