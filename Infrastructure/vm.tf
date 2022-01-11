
resource "google_compute_instance" "prv_vm" {
  name         = "private-vm"
  machine_type = "e2-small"
  zone         = "europe-west1-b"
  tags = ["http-server","https-server"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = 10
      type = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet1.id

  }


  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["cloud-platform"]
  }
}