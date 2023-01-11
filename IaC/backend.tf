#Armazena os arquivos de estado do terraform no bucket
terraform {
  backend "gcs" {
    bucket  = "projeto_carrefour_1234"
    prefix  = "terraform/state"
  }
}