resource "google_service_account" "custom" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}
resource "google_container_cluster" "primary" {
  name               = "main-private-cluster"
  location           = "europe-west1"
  initial_node_count = 1
  enable_autopilot = true
  network = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.subnet2.id

  ip_allocation_policy {
    cluster_ipv4_cidr_block = "/14"
    services_ipv4_cidr_block = "/20"
  }
  master_authorized_networks_config  {
    cidr_blocks {
      cidr_block   = "10.0.1.0/24"
      display_name = "trusted"
    }
  }
  node_config {
    service_account = google_service_account.custom.email

  }
  private_cluster_config {
      master_ipv4_cidr_block = "10.1.0.0/28"
      enable_private_nodes = true
      enable_private_endpoint = true
  }
}
# resource "google_container_cluster" "primary" {
#   name     = "private-gke"
#   location = "europe-west1"

#   # We can't create a cluster with no node pool defined, but we want to only use
#   # separately managed node pools. So we create the smallest possible default
#   # node pool and immediately delete it.
#   remove_default_node_pool = true
#   initial_node_count       = 1
#   network = google_compute_network.vpc_network.id
#   subnetwork = google_compute_subnetwork.subnet2.id
#   ip_allocation_policy {
#     cluster_ipv4_cidr_block = "/14"
#     services_ipv4_cidr_block = "/16"
#   }
#   node_config {
#     service_account = google_service_account.custom.email
#   }
#   private_cluster_config {
#     enable_private_nodes = true
#     enable_private_endpoint = true
#     master_ipv4_cidr_block = "172.16.0.0/28"
#   }
#   master_authorized_networks_config {
#     cidr_blocks {
#       cidr_block = "10.0.1.0/24"
#       display_name = "managment-subnet"
#     }
#   }

# }

# resource "google_container_node_pool" "primary_nodes" {
#   name       = "my-node-pool"
#   location   = "europe-west1"
#   cluster    = google_container_cluster.primary.name
#   node_count = 2
#   autoscaling {
#     min_node_count = 1
#     max_node_count = 3
#   }

#   node_config {
#     machine_type = "e2-medium"

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = google_service_account.custom.email
#     oauth_scopes    = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
#   depends_on = [google_container_cluster.primary]
# }