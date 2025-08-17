variable "cluster_name" {
  description = "Name of the Minikube cluster"
  type        = string
  default     = "minikube"
}

variable "environment" {
  description = "Environment name"
  type        = string
}