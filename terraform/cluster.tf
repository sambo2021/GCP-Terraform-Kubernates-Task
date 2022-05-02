resource "google_container_cluster" "primary"{
    name = "primary"
    location = "us-central1"
    remove_default_node_pool = true
    initial_node_count       = 1
    network                  = google_compute_network.main.self_link
    subnetwork               = google_compute_subnetwork.private.self_link
    node_locations = [ "us-central1-b","us-central1-c"]
    master_authorized_networks_config {
        cidr_blocks {
          #ofcourse only instances of public subnet would access the cluster 
          cidr_block = "10.1.0.0/24"
        }
    }
    private_cluster_config{
        enable_private_nodes = true
        enable_private_endpoint = true
        master_ipv4_cidr_block = "172.16.0.0/28"
    }
  
    ip_allocation_policy {
      cluster_secondary_range_name = "k8s-pod-range"
      services_secondary_range_name = "k8s-service-range"

    }
    # To Make Sure service account inside cluster  Workload Identity allows Kubernetes service accounts to act as a user-managed Google IAM Service Account.
    workload_identity_config {
      workload_pool= "sambo-project.svc.id.goog"
    }
    
}

resource "google_container_node_pool" "nodes"{
    name = "nodes"
    location = "us-central1"
    cluster = google_container_cluster.primary.name
    node_count = 1
    node_config {
      preemptible = false
      machine_type = "e2-micro"
      service_account = google_service_account.access.email
      disk_size_gb = 10
      oauth_scopes = [ 
               "https://www.googleapis.com/auth/cloud-platform"
            ]
    } 
}
