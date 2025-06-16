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

# Flatcar Container Linux template VM (assuming it's already prepared)
# For telmate/proxmox, we typically clone from an existing template
# You should prepare a Flatcar template VM manually first
