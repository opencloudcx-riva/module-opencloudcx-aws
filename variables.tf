variable "name" {
  type = string
}

variable "stack" {
  type    = string
  default = "dev"
}

variable "cluster_version" {
  type = string
}

variable "region" {
  type = string
}

variable "dns_zone" {
  type    = string
  default = "opencloudcx.internal"
}

variable "helm_timeout" {
  description = "Timeout value to wailt for helm chat deployment"
  type        = number
  default     = 600
}

### tags
variable "tags" {
  description = "The key-value maps for tagging"
  type        = map(string)
  default     = {}
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
  default     = "3.5.14"
}

###
###########################################################

###########################################################
### jenkins helm information
###

variable "cert_manager_helm_repo" {
  description = "URL for cert-manager helm chart repository"
  type        = string
  default     = "https://charts.jetstack.io"
}

###
###########################################################
