output "cluster_status" {
  description = "Minikube cluster status"
  value       = "running"
  depends_on  = [null_resource.minikube_status]
}

output "cluster_ip" {
  description = "Minikube cluster IP address"
  value       = trimspace(data.local_file.minikube_ip.content)
}

output "kubernetes_context" {
  description = "Kubernetes context name"
  value       = var.cluster_name
}

output "namespace" {
  description = "Kubernetes namespace for the environment"
  value       = kubernetes_namespace.environment.metadata[0].name
}