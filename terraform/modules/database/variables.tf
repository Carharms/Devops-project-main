variable "environment" {
  description = "Environment name"
  type        = string
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "postgres_port" {
  description = "Base PostgreSQL port"
  type        = number
  default     = 5432
}