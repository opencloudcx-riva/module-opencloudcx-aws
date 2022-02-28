##################################
## Jenkins 

resource "aws_secretsmanager_secret" "jenkins" {
  name                    = "${random_string.scope.id}-${var.stack}-jenkins"
  recovery_window_in_days = 0
}

resource "random_password" "jenkins" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "jenkins" {
  secret_id     = aws_secretsmanager_secret.jenkins.id
  secret_string = "{\"username\": \"admin\", \"password\": \"${random_password.jenkins.result}\"}"
}

##################################
## Portainer

resource "aws_secretsmanager_secret" "portainer" {
  name                    = "${random_string.scope.id}-${var.stack}-portainer"
  recovery_window_in_days = 0
}

resource "random_password" "portainer" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "portainer" {
  secret_id     = aws_secretsmanager_secret.portainer.id
  secret_string = "{\"username\": \"admin\", \"password\": \"${random_password.portainer.result}\"}"
}

##################################
## Sonarqube

resource "aws_secretsmanager_secret" "sonarqube" {
  name                    = "${random_string.scope.id}-${var.stack}-sonarqube"
  recovery_window_in_days = 0
}

resource "random_password" "sonarqube" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "sonarqube" {
  secret_id     = aws_secretsmanager_secret.sonarqube.id
  secret_string = "{\"username\": \"admin\", \"password\": \"${random_password.sonarqube.result}\"}"
}

##################################
## Keycloak

resource "aws_secretsmanager_secret" "keycloak_admin" {
  name                    = "${random_string.scope.id}-${var.stack}-keycloak-admin"
  recovery_window_in_days = 0
}

resource "random_password" "keycloak_admin" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "keycloak_admin" {
  secret_id     = aws_secretsmanager_secret.keycloak_admin.id
  secret_string = "{\"username\": \"user\", \"password\": \"${random_password.keycloak_admin.result}\"}"
}

resource "aws_secretsmanager_secret" "keycloak_user" {
  name                    = "${random_string.scope.id}-${var.stack}-keycloak-user"
  recovery_window_in_days = 0
}

resource "random_password" "keycloak_user" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "keycloak_user_secret_version" {
  secret_id     = aws_secretsmanager_secret.keycloak_user.id
  secret_string = "{\"username\": \"manager\", \"password\": \"${random_password.keycloak_user.result}\"}"
}

##################################
## Grafana 

resource "aws_secretsmanager_secret" "grafana" {
  name                    = "${random_string.scope.id}-${var.stack}-grafana"
  recovery_window_in_days = 0
}

resource "random_password" "grafana" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "grafana" {
  secret_id     = aws_secretsmanager_secret.grafana.id
  secret_string = "{\"username\": \"admin\", \"password\": \"${random_password.grafana.result}\"}"
}

##################################
## Influxdb

resource "aws_secretsmanager_secret" "influx_admin" {
  name                    = "${random_string.scope.id}-${var.stack}-influx-admin"
  recovery_window_in_days = 0
}

resource "random_password" "influx_admin" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "influx_admin" {
  secret_id     = aws_secretsmanager_secret.influx_admin.id
  secret_string = "{\"username\": \"admin\", \"password\": \"${random_password.influx_admin.result}\"}"
}

resource "aws_secretsmanager_secret" "influx_user" {
  name                    = "${random_string.scope.id}-${var.stack}-influx-user"
  recovery_window_in_days = 0
}

resource "random_password" "influx_user" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "influx_user" {
  secret_id     = aws_secretsmanager_secret.influx_user.id
  secret_string = "{\"username\": \"user\", \"password\": \"${random_password.influx_user.result}\"}"
}



