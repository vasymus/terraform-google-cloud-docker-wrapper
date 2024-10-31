output "kubeconfig" {
  description = "Kubeconfig file to connect to the cluster"
  value       = google_container_cluster.primary.endpoint
}

output "client_certificate" {
  description = "Client certificate data"
  value       = google_container_cluster.primary.master_auth.0.client_certificate
}

output "client_key" {
  description = "Client key data"
  value       = google_container_cluster.primary.master_auth.0.client_key
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}