variable "project_id" {
  description = "id do projeto criado no gcp"
  default     = "pro-lattice-368817"
}

variable "project_name" {
  description = "nome do projeto"
  default = "projeto-carrefour"
}

variable "region" {
  description = "regiao do projeto"
  default     = "us-west4"
}

variable "zone" {
  default = "us-west4-a"
}

# variable "filestorename" {
#   description = "nome do filestore"
#   default = "dados"
# }

# variable "filestorecomp" {
#   description = "nome do compartilhamento filestore"
#   default = "database"
# }

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}

variable "bd_senha" {
  type = string
}

variable "bd_nome" {
  type = string
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

variable "use_private_endpoint" {
  type        = bool
  description = "Connect on the private GKE cluster endpoint"
  default     = false
}

variable "github_deploy_key_title" {
  type        = string
  description = "Name of github deploy key"
  default     = "key_flux"
}