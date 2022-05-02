##subnets
resource "google_compute_subnetwork" "public" {
name = "public"
ip_cidr_range = "10.1.0.0/24"
region = "us-central1"
network = google_compute_network.main.id
}

resource "google_compute_subnetwork" "private" {
   name = "private"
   ip_cidr_range = "10.2.0.0/24"
   region = "us-central1"
   network = google_compute_network.main.id
   secondary_ip_range {
      range_name = "k8s-pod-range"
      ip_cidr_range = "10.3.0.0/20"
    }
    secondary_ip_range {
      range_name = "k8s-service-range"
      ip_cidr_range = "10.4.0.0/20"
    }
}
###################################################
##ssh fire wall
resource "google_compute_firewall" "allow-ssh"{
    name = "allow-ssh"
    network = google_compute_network.main.name
    allow{
        protocol = "tcp"
        ports = ["22","80","443"]
    }
    source_ranges = ["0.0.0.0/0"]
}
###################################################
## router 


resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.public.region 
  network = google_compute_network.main.id
}
#####################################################
## nat getway
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork{
      name = google_compute_subnetwork.public.id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


