variable "environment" {
  description = "Environment name"
  type        = string
}

variable "jenkins_port" {
  description = "Jenkins port number"
  type        = number
  default     = 8080
}