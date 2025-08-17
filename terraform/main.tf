terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Configure providers for Windows
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
  
}

# Minikube cluster module
module "minikube" {
  source = "./modules/minikube"
  
  cluster_name = var.cluster_name
  environment  = var.environment
}

# Database module
module "database" {
  source = "./modules/database"
  
  environment       = var.environment
  postgres_db       = var.postgres_db
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  
  depends_on = [module.minikube]
}

# Jenkins module (local setup)
module "jenkins" {
  source = "./modules/jenkins"
  
  environment  = var.environment
  jenkins_port = var.jenkins_port
}