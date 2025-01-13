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

resource "kubernetes_cluster_role_binding" "oauth2_proxy_admin" {
  metadata {
    name = "oauth2-proxy-admin-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin" # Accorde les droits d'administrateur
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.oauth2_proxy.metadata[0].name
    namespace = var.namespace
  }
}

data "kubernetes_secret" "oauth2_proxy_token" {
  depends_on = [kubernetes_secret.oauth2_proxy_token]

  metadata {
    name      = kubernetes_secret.oauth2_proxy_token.metadata[0].name
    namespace = var.namespace
  }
}


locals {
  bearer_token = nonsensitive(data.kubernetes_secret.oauth2_proxy_token.data["token"])
}