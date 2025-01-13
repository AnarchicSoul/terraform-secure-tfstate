resource "kubernetes_service_account" "oauth2_proxy" {
  metadata {
    name      = "oauth2-proxy"
    namespace = var.namespace
  }
}


data "kubernetes_secret" "oauth2_proxy_token" {
  metadata {
    name      = kubernetes_service_account.oauth2_proxy.default_secret_name
    namespace = var.namespace
  }
}

locals {
  bearer_token = base64decode(data.kubernetes_secret.oauth2_proxy.data["token"])
}