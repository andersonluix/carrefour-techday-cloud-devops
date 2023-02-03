provider "google" {
    project = "pro-lattice-368817"
    region  = var.region
    zone    = var.zone
}

# provider "kubectl" {
#   host                   = "https://${google_container_cluster.cluster.endpoint}"
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
#   load_config_file       = false
# }

#Conf K8's OAuth2 access token
data "google_client_config" "default" {}

#data "google_container_cluster" "my_cluster" {
#  name = "example"
#  location = var.zone
#}

# provider "kubernetes" {
#   host                   = "https://${google_container_cluster.cluster.endpoint}"
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
# }

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/auth
module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version              = ">= 24.0.0"
  project_id           = var.project_id
  cluster_name         = google_container_cluster.cluster.name
  location             = var.region
  use_private_endpoint = var.use_private_endpoint
}

provider "kubernetes" {
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
}

provider "kubectl" {
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
  load_config_file       = false
}

provider "flux" {}

# Github
provider "github" {
  token        = var.github_token
  owner        = var.github_owner
}

