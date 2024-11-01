output "kubeconfig" {
  description = "Kubeconfig file to connect to the cluster"
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
}

output "client_certificate" {
  description = "Client certificate data"
  value       = google_container_cluster.primary.master_auth.0.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client key data"
  value       = google_container_cluster.primary.master_auth.0.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  sensitive   = true
}
