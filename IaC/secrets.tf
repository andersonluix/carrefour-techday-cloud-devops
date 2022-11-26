#Cria o Secret no GKE
resource "kubernetes_secret" "my-secret" {
  metadata {
    name = "my-secret"
    }
  data = {
    ROOT_PASSWORD = "Senha123"
    MYSQL_DATABASE = "meubanco"
    }
  }
