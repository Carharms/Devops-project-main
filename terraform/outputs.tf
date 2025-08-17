output "minikube_status" {
  description = "Minikube cluster status"
  value       = module.minikube.cluster_status
}

output "minikube_ip" {
  description = "Minikube cluster IP address"
  value       = module.minikube.cluster_ip
}

output "kubernetes_context" {
  description = "Kubernetes context name"
  value       = module.minikube.kubernetes_context
}

output "database_connection_string" {
  description = "PostgreSQL connection details"
  value       = module.database.connection_string
  sensitive   = true
}

output "database_host" {
  description = "Database host address"
  value       = module.database.host
}

output "database_port" {
  description = "Database port"
  value       = module.database.port
}

output "jenkins_url" {
  description = "Jenkins server URL"
  value       = module.jenkins.jenkins_url
}

output "jenkins_status" {
  description = "Jenkins service status"
  value       = module.jenkins.status
}

output "environment_info" {
  description = "Environment configuration summary"
  value = {
    environment = var.environment
    cluster     = var.cluster_name
    services = {
      frontend = "http://localhost:${var.frontend_port}"
      product  = "http://localhost:${var.product_port}"
      order    = "http://localhost:${var.order_port}"
      database = "localhost:${var.postgres_port}"
      jenkins  = "http://localhost:${var.jenkins_port}"
    }
  }
}