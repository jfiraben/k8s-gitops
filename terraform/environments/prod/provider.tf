terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  
  # Skip TLS verification (only if you're using self-signed certificates)
  pm_tls_insecure = true
}

provider "kubernetes" {
  config_path = var.kube_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
  debug = true
}

provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_root_token
}
