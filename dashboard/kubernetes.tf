resource "kubernetes_service_account" "oauth2_proxy" {
  metadata {
    name      = "oauth2-proxy"
    namespace = var.namespace
  }
}


data "kubernetes_secret" "oauth2_proxy" {
  depends_on = [kubernetes_service_account.oauth2_proxy]

  metadata {
    namespace = var.namespace
    name      = kubernetes_service_account.oauth2_proxy.secrets[0].name
  }
}


locals {
  bearer_token = base64decode(data.kubernetes_secret.oauth2_proxy.data["token"])
}