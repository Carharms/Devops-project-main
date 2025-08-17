# Minikube Module - Windows Compatible
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

resource "null_resource" "minikube_status" {
  provisioner "local-exec" {
    command     = "minikube start --profile=${var.cluster_name} --driver=docker"
    interpreter = ["PowerShell", "-Command"]
  }

  triggers = {
    cluster_name = var.cluster_name
    environment  = var.environment
  }
}

resource "null_resource" "kubectl_context" {
  provisioner "local-exec" {
    command     = "kubectl config use-context ${var.cluster_name}"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [null_resource.minikube_status]
}

# Get minikube IP using local-exec
resource "null_resource" "get_minikube_ip" {
  provisioner "local-exec" {
    command     = "minikube ip --profile=${var.cluster_name} > minikube_ip.txt"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [null_resource.minikube_status]
}

# Read the IP from file
data "local_file" "minikube_ip" {
  filename = "minikube_ip.txt"
  depends_on = [null_resource.get_minikube_ip]
}

# Wait for cluster to be ready
resource "null_resource" "wait_for_cluster" {
  provisioner "local-exec" {
    command     = "Start-Sleep -Seconds 30"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [null_resource.kubectl_context]
}

# Create namespace for the environment
resource "kubernetes_namespace" "environment" {
  metadata {
    name = var.environment
    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  depends_on = [null_resource.wait_for_cluster]
}