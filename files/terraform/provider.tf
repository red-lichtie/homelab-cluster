# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {
    required_version = ">= 0.14"
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "2.9.11"
        }
    }
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
}

variable "proxmox_api_token_secret" {
    type = string
}

provider "proxmox" {
    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret
    pm_debug      = true
    pm_log_enable = true
    pm_log_file   = "terraform-plugin-proxmox.log"
    pm_log_levels = {
      _default    = "debug"
      _capturelog = ""
    }
}
