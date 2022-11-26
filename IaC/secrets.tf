#Cria o Secret no GKE
resource "kubernetes_secret" "my-secret" {
  metadata {
    name = "my-secret"
    }
  data = {
    ROOT_PASSWORD = var.bd_senha
    MYSQL_DATABASE = var.bd_nome
    }
  }
