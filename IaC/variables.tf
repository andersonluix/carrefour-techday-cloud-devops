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

variable "repository_name" {
  description = "repository name"
  type        = string
  default     = "carrefour-techday-cloud-devops-flux"
}