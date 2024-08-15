terraform {
    required_version = ">= 0.14"
    required_providers {
        proxmox = {
            source  = "registry.example.com/telmate/proxmox"
            version = ">= 1.0.0"
        }
    }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://proxmox.fleeforezz.me/api2/json"
    pm_api_token_secret = "5d379194-1856-4e13-9cc8-0a5876509ad8"
    pm_api_token_id = "root@pam!terraform"
}