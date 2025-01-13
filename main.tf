terraform {
  backend "s3" {
    bucket = "my-minio-bucket"
    key = "terraform.tfstate"
    endpoints = {
        s3 = "https://minioapi.localhost"
    }
    region = "main"
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_metadata_api_check = true
    skip_region_validation = true
    use_path_style = true 
    insecure = true
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = local.kubeconfig
  }
}

provider "kubernetes" {
    config_path = local.kubeconfig
}

