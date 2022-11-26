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

variable "filestorename" {
  description = "nome do filestore"
  default = "dados"
}

variable "filestorecomp" {
  description = "nome do compartilhamento filestore"
  default = "database"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "bd_senha" {
  type = string
}

variable "bd_nome" {
  type = string
}