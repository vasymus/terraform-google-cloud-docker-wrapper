provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = var.node_count

  remove_default_node_pool = true
  network                = "default"
  subnetwork             = "default"

  # Master Authorized Networks (optional)
  # master_authorized_networks_config {
  #   cidr_blocks = [
  #     {
  #       cidr_block   = "0.0.0.0/0"
  #       display_name = "Public"
  #     },
  #   ]
  # }

  # Add any additional configurations as needed
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }

  # Optional: Enable autoscaling
  # autoscaling {
  #   min_node_count = 1
  #   max_node_count = 5
  # }
}
