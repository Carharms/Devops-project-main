# Staging Environment Variables
environment = "staging"
cluster_name = "minikube-staging"

# Database configuration
postgres_db = "microservices_staging"
postgres_user = "postgres"
postgres_password = "staging_password123"

# Service ports for staging environment (offset by 10)
jenkins_port = 8090
frontend_port = 3010
product_port = 3011
order_port = 3012
postgres_port = 5442