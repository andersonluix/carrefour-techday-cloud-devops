#Cria o Secret no GKE
resource "kubernetes_secret" "my-secret" {
  metadata {
    name = "my-secret"
    }
  data = {
    ROOT_PASSWORD = "${{ secrets.SECRET_SENHA }}"
    MYSQL_DATABASE = "${{ secrets.SECRET_DATABASE }}"
    }
  }