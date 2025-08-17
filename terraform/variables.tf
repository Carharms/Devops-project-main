variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Minikube cluster name"
  type        = string
  default     = "minikube"
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "microservices_db"
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "postgres"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  default     = "password123"
  sensitive   = true
}

variable "jenkins_port" {
  description = "Jenkins port number"
  type        = number
  default     = 8080
}

variable "frontend_port" {
  description = "Frontend service port"
  type        = number
  default     = 3000
}

variable "product_port" {
  description = "Product service port"
  type        = number
  default     = 3001
}

variable "order_port" {
  description = "Order service port"
  type        = number
  default     = 3002
}

variable "postgres_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}