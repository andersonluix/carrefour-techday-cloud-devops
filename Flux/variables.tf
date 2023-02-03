variable "project_id" {
  description = "project id"
  type        = string
  default     = "pro-lattice-368817"
}

variable "github_token" {
  description = "token for github"
  type        = string
}

variable "github_owner" {
  description = "github owner"
  type        = string
}

variable "repository_name" {
  description = "repository name"
  type        = string
  default     = "carrefour-techday-cloud-devops-flux"
}

variable "branch" {
  description = "branch"
  type        = string
  default     = "main"
}

variable "target_path" {
  type        = string
  description = "Relative path to the Git repository root where the sync manifests are committed."
  default     = "clusters/carrefour-techday"
}

variable "flux_namespace" {
  type        = string
  default     = "flux-system"
  description = "the flux namespace"
}

variable "cluster_name" {
  type        = string
  description = "cluster name"
  default     = "projeto-carrefour-gke"
}

variable "cluster_region" {
  type        = string
  description = "cluster region"
  default     = "us-west4-a"
}

variable "use_private_endpoint" {
  type        = bool
  description = "Connect on the private GKE cluster endpoint"
  default     = false
}

variable "github_deploy_key_title" {
  type        = string
  description = "Name of github deploy key"
  default       = "key_flux"
}
