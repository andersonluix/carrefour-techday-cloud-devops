terraform {
  required_providers {
    google = {
      version = "4.44.1"
    }
    kubectl = {
      version = "1.14.0"
      source = "gavinbunney/kubectl"
    }
  }
}