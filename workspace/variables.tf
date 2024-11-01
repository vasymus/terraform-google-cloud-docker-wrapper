variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-west1"
}

variable "credentials_file" {
  description = "Path to the GCP credentials JSON file"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "my-gke-cluster"
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type for the nodes"
  type        = string
  default     = "f1-micro"
}

variable "deletion_protection" {
  description = "Enable deletion protection for the GKE cluster"
  type        = bool
  default     = false
}
