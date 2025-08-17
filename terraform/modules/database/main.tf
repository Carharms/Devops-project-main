# PostgreSQL Database Module
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "postgres" {
  name = "postgres:15-alpine"
}

resource "docker_container" "postgres" {
  name  = "postgres-${var.environment}"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

  ports {
    internal = 5432
    external = var.postgres_port + (var.environment == "dev" ? 0 : var.environment == "staging" ? 10 : 20)
  }

  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = "${path.cwd}/data/${var.environment}/postgres"
  }

  restart = "unless-stopped"

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "service"
    value = "database"
  }
}

# Health check for database
# Health check for database
resource "null_resource" "db_health_check" {
  provisioner "local-exec" {
    command     = "Start-Sleep -Seconds 30; docker exec postgres-${var.environment} pg_isready -U ${var.postgres_user} -d ${var.postgres_db}"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [docker_container.postgres]
}