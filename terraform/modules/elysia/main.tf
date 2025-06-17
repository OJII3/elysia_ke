terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc01"
    }
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


