resource "kubernetes_service_account" "oauth2_proxy" {
  metadata {
    name      = "oauth2-proxy"
    namespace = var.namespace
  }
  automount_service_account_token = true
}

resource "kubernetes_secret" "oauth2_proxy_token" {
  metadata {
    name      = "oauth2-proxy-token"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.oauth2_proxy.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

data "kubernetes_secret" "oauth2_proxy_token" {
  depends_on = [kubernetes_secret.oauth2_proxy_token]

  metadata {
    name      = kubernetes_secret.oauth2_proxy_token.metadata[0].name
    namespace = var.namespace
  }
}


locals {
  bearer_token = base64decode(tostring(data.kubernetes_secret.oauth2_proxy_token.data["token"]))
}