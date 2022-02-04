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

variable "full_dns_zone" {
  type    = string
  default = "stack.opencloudcx.internal"
}

variable "additional_namespaces" {
  description = "Additional namespaces to create in cluster"
  type        = list(string)
  default     = []
}

variable "ecr_repos" {
  description = "ECR repositories to create"
  type        = list(string)
  default     = []
}

variable "helm_timeout" {
  description = "Timeout value to wait for helm chart deployment"
  type        = number
  default     = 600
}

### tags
variable "tags" {
  description = "The key-value maps for tagging"
  type        = map(string)
  default     = {}
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "worker_groups" {
  type = list(object({
    name                 = string
    instance_type        = string
    asg_desired_capacity = number
  }))
}

variable "cluster_delete_timeout" {
  description = "Timeout value when deleting the EKS cluster."
  type        = string
  default     = "15m"
}

variable "write_kubeconfig" {
  description = "Whether to write a Kubectl config file containing the cluster configuration. Saved to `kubeconfig_output_path`."
  type        = bool
  default     = true
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "aws_certificate_arn" {
  description = "AWS SSL certificate ARN"
  type        = string
}

variable "aws_certificate_cname" {
  type = string
}

variable "aws_certificate_cname_value" {
  type = string
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
### selenium helm information
###

variable "selenium_helm_repo" {
  description = "URL for selenium helm chart repository"
  type        = string
  default     = "https://chart.testarchitect.com"
}

variable "selenium_helm_chart_version" {
  description = "Version for selenium helm chart"
  type        = string
  default     = "1.2.4"
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

