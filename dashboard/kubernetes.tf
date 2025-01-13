resource "kubernetes_service_account" "oauth2_proxy" {
  metadata {
    name      = "oauth2-proxy"
    namespace = var.namespace
  }
}
resource "kubernetes_secret" "oauth2_proxy_token" {
  metadata {
    name      = "oauth2-proxy-token"
    namespace = var.namespace
  }

  data = {
    token = data.kubernetes_service_account.oauth2_proxy.token
  }
}

data "kubernetes_secret" "oauth2_proxy_token" {
  depends_on = [kubernetes_secret.oauth2_proxy_token]
  metadata {
    name      = "oauth2-proxy-token"
    namespace = var.namespace
  }
}