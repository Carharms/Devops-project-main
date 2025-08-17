# Jenkins Local Setup Module
# This module assumes Jenkins is locally installed
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

resource "null_resource" "jenkins_check" {
  provisioner "local-exec" {
    command     = "Test-NetConnection -ComputerName localhost -Port ${var.jenkins_port}"
    interpreter = ["PowerShell", "-Command"]
  }

  triggers = {
    environment = var.environment
    port        = var.jenkins_port
  }
}

# Create Jenkins workspace directory for the environment
resource "null_resource" "jenkins_workspace" {
  provisioner "local-exec" {
    command     = "New-Item -ItemType Directory -Force -Path '${path.cwd}/jenkins-workspace/${var.environment}'"
    interpreter = ["PowerShell", "-Command"]
  }

  triggers = {
    environment = var.environment
  }
}

# Create environment-specific Jenkins configuration
resource "local_file" "jenkins_env_config" {
  filename = "${path.cwd}/jenkins-config/${var.environment}.properties"
  content  = <<-EOF
    ENVIRONMENT=${var.environment}
    JENKINS_PORT=${var.jenkins_port}
    WORKSPACE_PATH=${path.cwd}/jenkins-workspace/${var.environment}
    CREATED_BY=terraform
  EOF

  depends_on = [null_resource.jenkins_workspace]
}