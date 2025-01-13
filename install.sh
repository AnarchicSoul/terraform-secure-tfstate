#!/bin/bash

# Terraform login (si nécessaire)
terraform init -backend-config="access_key=$MINIO_ACCESS_KEY" -backend-config="secret_key=$MINIO_SECRET_KEY"

# Appliquer les ressources restantes
terraform apply -auto-approve 
