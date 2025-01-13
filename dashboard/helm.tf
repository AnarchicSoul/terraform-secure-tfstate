#######################################################################################
# HELM INSTALL
#######################################################################################

resource "helm_release" "dashboard" {
  name       = "dashboard"
  namespace  = var.namespace
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
} 