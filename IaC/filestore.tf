#Filestore
resource "google_filestore_instance" "instance" {
  name = var.filestorename
  location = var.zone
  tier = "BASIC_HDD"

  file_shares {
    capacity_gb = 1024
    name        = var.filestorecomp
  }

  networks {
    network = google_compute_network.vpc.name
    modes   = ["MODE_IPV4"]
  }
}