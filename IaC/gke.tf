# GKE cluster
 
resource "google_container_cluster" "cluster" {
  name               = "${var.project_name}-gke"
  location               = var.zone
  
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "pool" {
  name = "${var.project_name}-pool"
  cluster = google_container_cluster.cluster.name
  location = var.zone
  node_count = var.gke_num_nodes

  node_config {
    machine_type = "e2-small"
    }
  }

