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

resource "proxmox_virtual_environment_download_file" "eeke-mobius" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "anaxa"

  url = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "eeke-pardofelis" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "mydei"

  url = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "eeke-eden" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "phainon"

  url = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
}
