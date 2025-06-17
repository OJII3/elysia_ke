terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
  backend "s3" { # R2 is compatible with S3 API
    bucket = "elysia-ke-tfstate"
    key = "default.state"
    region = "us-east-1"
    endpoints = "https://${var.proxmox_config.cloudflare_account_id}.r2.cloudflarestorage.com"
    skip_credentials_validation = true # no aws access key
  }
}

provider "proxmox" {
  pm_api_url = "${var.proxmox_config.endpoint}"
  pm_user = "${var.proxmox_config.username}"
  pm_password = "${var.proxmox_config.password}"
}

data "local_file" "ssh_public_key" {
  filename = "${var.proxmox_config.pub_key_file}"
}

# Common ISO file for all VMs
locals {
  fedora_coreos_iso = "local:iso/fedora-coreos-42.20250526.3.0-live-iso.x86_64.iso"
}


