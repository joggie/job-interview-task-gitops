terraform {
  required_version = ">= 1.9.0"
# backend "http" {}

  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.64.0"
    }
#    vault = {
#      source = "hashicorp/vault"
#      version = "4.5.0"
#    }
  }
}

provider "exoscale" {
#  key = data.vault_generic_secret.exo-api-key.data["API_KEY"]
#  secret = data.vault_generic_secret.exo-api-key.data["API_SECRET"]
}

#provider "vault" {
#  address = var.vault_address
#  token = var.vault_token
#}