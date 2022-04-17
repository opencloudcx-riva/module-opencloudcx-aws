variable "aws_region" {
  description = "The aws region to deploy the service into"
  type        = string
  default     = "us-east-1"
}

# variable "access_key" {
#   description = "AWS access key"
#   type        = string
# }

# variable "secret_key" {
#   description = "AWS secret key"
#   type        = string
# }

# variable "kubernetes_cluster_endpoint" {
#   type = string
# }

# variable "kubernetes_auth_token" {
#   type = string
# }

# variable "kubernetes_cluster_ca_certificate" {
#   type = string
# }

variable "kubernetes_dockerhub_secret_name" {
  description = "Kubernetes dockerhub secret name. This is the reference name used within a kaniko pods"
  type        = string
}

variable "kubernetes_secret_dockerhub_username" {
  description = "Kubernetes secret dockerhub username"
  type        = string
}

variable "kubernetes_secret_dockerhub_password" {
  description = "Kubernetes secret dockerhub password"
  type        = string
}

variable "kubernetes_secret_dockerhub_email" {
  description = "Kubernetes secret dockerhub email"
  type        = string
}

variable "kubernetes_dockerhub_secret_repository_url" {
  description = "URL for dockerhub registry"
  type        = string
  default     = "https://index.docker.io/v1/"
}

variable "random_seed" {
  type = string
}

variable "stack" {
  type = string
}

variable "helm_timeout" {
  description = "Timeout value to wait for helm chart deployment"
  type        = number
  default     = 600
}

variable "dns_zone" {
  type    = string
  default = "opencloudcx.internal"
}

variable "full_dns_zone" {
  type    = string
  default = "stack.opencloudcx.internal"
}

###########################################################
### Spinnaker helm information
###

variable "spinnaker_helm_repo" {
  description = "A repository url of helm chart to deploy a spinnaker instance"
  type        = string
  default     = "https://helmcharts.opsmx.com/"
  # default     = "https://opencloudcx.github.io/spinnaker-helm"
}

variable "spinnaker_helm_chart_version" {
  description = "The version of helm chart to deploy spinnaker instance"
  type        = string
  default     = "2.2.7"
}

###
###########################################################

###########################################################
### nginx ingress helm information
###

variable "ingress_helm_repo" {
  description = "URL for Ingress Controller helm chart"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "ingress_helm_chart_version" {
  description = "Helm chart version for ingress"
  type        = string
  default     = "4.0.19"
}

###
###########################################################

###########################################################
### k8s dashboard helm information
###

variable "k8s_dashboard_helm_repo" {
  description = "A repository url of helm chart to deploy k8s dashboard"
  type        = string
  default     = "https://kubernetes.github.io/dashboard/"
}

variable "k8s_dashboard_helm_chart_version" {
  description = "Helm chart version for k8s_dashboard"
  type        = string
  default     = "5.0.3"
}

###
###########################################################

###########################################################
### jenkins helm information
###

variable "jenkins_helm_repo" {
  description = "A repository url of the helm chart to deploy jenkins."
  type        = string
  default     = "https://charts.jenkins.io"
}

variable "jenkins_helm_chart_version" {
  description = "Helm chart version for jenkins"
  type        = string
  default     = "3.9.3"
}

###
###########################################################

###########################################################
### cert_manager helm information
###

variable "cert_manager_helm_repo" {
  description = "URL for cert-manager helm chart repository"
  type        = string
  default     = "https://charts.jetstack.io"
}

variable "cert_manager_helm_chart_version" {
  description = "Version for cert manager helm chart"
  type        = string
  default     = "1.8.0"
}

###
###########################################################

###########################################################
### keycloak helm information
###

variable "keycloak_helm_repo" {
  description = "URL for keycloak helm chart repository"
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
}

variable "keycloak_helm_chart_version" {
  description = "Version for keycloak helm chart"
  type        = string
  default     = "5.1.2"
}

###
###########################################################

###########################################################
### grafana helm information
###

variable "grafana_helm_repo" {
  description = "URL for grafana helm chart repository"
  type        = string
  default     = "https://grafana.github.io/helm-charts"
}

variable "grafana_helm_chart_version" {
  description = "Version for grafana helm chart"
  type        = string
  default     = "6.17.5"
}

###
###########################################################

###########################################################
### influxdb helm information
###

variable "influxdb_helm_repo" {
  description = "A repository url of helm chart to deploy InfluxDB"
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
}

variable "influxdb_helm_chart_version" {
  description = "Version for InfluxDB helm chart"
  type        = string
  default     = "2.4.1"
}

###
###########################################################

###########################################################
### SonarQube helm information
###

variable "sonarqube_helm_repo" {
  description = "A repository url of helm chart to deploy sonarqube"
  type        = string
  default     = "https://SonarSource.github.io/helm-chart-sonarqube"
}

variable "sonarqube_helm_chart_version" {
  description = "Version for sonarqube helm chart"
  type        = string
  default     = "1.2.0+150"
}

###
###########################################################

###########################################################
### Prometheus helm information
###

variable "prometheus_helm_repo" {
  description = "A repository url of helm chart to deploy prometheus"
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
}

variable "prometheus_helm_chart_version" {
  description = "Version for prometheus helm chart"
  type        = string
  default     = "14.12.0"
}

###
###########################################################
