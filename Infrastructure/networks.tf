resource "google_compute_network" "vpc_network" {
  name                    = "main"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
}
resource "google_compute_subnetwork" "subnet1" {
  name          = "managment-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_subnetwork" "subnet2" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_router" "router" {
  name    = "router1"
  region  = google_compute_subnetwork.subnet1.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat1"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-from-iap"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["35.235.240.0/20"]
}