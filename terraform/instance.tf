
resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "e2-micro"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.public.id
  }
  service_account {
    email  = google_service_account.access.email
    scopes = ["cloud-platform"]
  }
}

