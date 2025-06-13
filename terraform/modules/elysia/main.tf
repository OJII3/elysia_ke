terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.66.2"
    }
  }
}

provider "proxmox" {
  endpoint = "${var.proxmox_config.endpoint}"
  username = "${var.proxmox_config.username}"
  password = "${var.proxmox_config.password}"
  insecure = true
}

data "local_file" "ssh_public_key" {
  filename = "${var.proxmox_config.pub_key_file}"
}

# Flatcar Container Linux cloud image for all VMs - download once to the cluster
resource "proxmox_virtual_environment_download_file" "flatcar_cloud_image" {
  content_type       = "iso"
  datastore_id       = "local"
  node_name          = "cipher"
  file_name          = "flatcar_production_qemu_image.img"
  overwrite          = false

  url = "https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_qemu_image.img.bz2"
}
