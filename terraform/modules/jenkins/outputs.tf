output "jenkins_url" {
  description = "Jenkins server URL"
  value       = "http://localhost:${var.jenkins_port}"
}

output "status" {
  description = "Jenkins status"
  value       = "configured"
  depends_on  = [null_resource.jenkins_check]
}

output "workspace_path" {
  description = "Jenkins workspace path for environment"
  value       = "${path.cwd}/jenkins-workspace/${var.environment}"
}

output "config_file" {
  description = "Jenkins environment configuration file"
  value       = local_file.jenkins_env_config.filename
}