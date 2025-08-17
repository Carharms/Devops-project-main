# Production Environment Variables
environment = "prod"
cluster_name = "minikube-prod"

# Database configuration
postgres_db = "microservices_prod"
postgres_user = "postgres"
postgres_password = "prod_password123"

# Service ports for production environment (offset by 20)
jenkins_port = 8100
frontend_port = 3020
product_port = 3021
order_port = 3022
postgres_port = 5452