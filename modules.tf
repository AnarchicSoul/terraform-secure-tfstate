module "dashboard" {
    source = "./dashboard"
    count  = var.dashboard ? 1 : 0
    namespace  = local.namespace
    #dashboard_ingress  = local.dashboard_ingress
}
