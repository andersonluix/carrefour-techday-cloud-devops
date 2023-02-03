provider "google" {
    project = "pro-lattice-368817"
    region  = var.region
    zone    = var.zone
}

provider "kubectl" {
  host                   = "https://${google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
  load_config_file       = false
}

#Conf K8's OAuth2 access token
data "google_client_config" "default" {}

#data "google_container_cluster" "my_cluster" {
#  name = "example"
#  location = var.zone
#}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

provider "flux" {}

# Github
provider "github" {
  token        = var.github_token
  owner        = var.github_owner
}