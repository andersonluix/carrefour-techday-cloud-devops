terraform {
  required_providers {
    google = {
      version = "4.44.1"
    }
    kubectl = {
      version = "1.14.0"
      source = "gavinbunney/kubectl"
    }
        github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}