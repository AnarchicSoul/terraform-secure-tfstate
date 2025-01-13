#######################################################################################
## Base Config
#######################################################################################
# Careful if you modify this part, be sure to know your cluster. 
# Base component can be disabled from install, but be sure they exists ! 


## Common config
locals {
    mydomain    = "${yamldecode(file("config.yaml")).baseconfig.common.mydomain}"
}

## Kubernetes config 
locals {
    namespace    = "${yamldecode(file("config.yaml")).baseconfig.kubernetes.namespace}"
    kubeconfig    = "${yamldecode(file("config.yaml")).baseconfig.kubernetes.kubeconfig}"
}


## Dashboard Config
variable "dashboard" {
    description = "enable = true & disable = false"
    type        = bool
    default     = true
} 
locals {
    dashboard_host = "${yamldecode(file("config.yaml")).baseconfig.dashboard.dashboard_host}"
    dashboard_ingress = "${local.dashboard_host}.${local.mydomain}"
    keycloak_host = "${yamldecode(file("config.yaml")).baseconfig.keycloak.keycloak_host}"
    keycloak_ingress = "${local.keycloak_host}.${local.mydomain}"
}

