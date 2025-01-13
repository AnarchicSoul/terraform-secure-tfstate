#######################################################################################
# HELM INSTALL
#######################################################################################

resource "helm_release" "dashboard" {
  name       = "dashboard"
  namespace  = var.namespace
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  set {
    name  = "args[0]"
    value = "--disable-settings-authorizer"
  }

  set {
    name  = "extraArgs"
    value = "--enable-skip-login"
  }

  set {
    name  = "rbac.clusterReadOnlyRole"
    value = "true"
  }
} 

resource "helm_release" "dashboard_ingress" {
  depends_on = [helm_release.dashboard]
  name       = "oauth2-dashboard"
  namespace  = var.namespace
  repository = "https://oauth2-proxy.github.io/manifests"
  chart      = "oauth2-proxy"
  version    = "7.7.4"
  values = [local.proxy_oauth_dashboard]
} 