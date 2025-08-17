output "connection_string" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${var.postgres_user}:${var.postgres_password}@localhost:${docker_container.postgres.ports[0].external}/${var.postgres_db}"
  sensitive   = true
}

output "host" {
  description = "Database host"
  value       = "localhost"
}

output "port" {
  description = "Database port"
  value       = docker_container.postgres.ports[0].external
}

output "database_name" {
  description = "Database name"
  value       = var.postgres_db
}

output "container_name" {
  description = "Docker container name"
  value       = docker_container.postgres.name
}