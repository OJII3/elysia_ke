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

# Control Plane & Worker nodes ###################
resource "proxmox_virtual_environment_download_file" "kevin" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "kevin"

  url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "eden" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "eden"

  url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "mobius" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "mobius"

  url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

# Load Balancer node (kube-vip) ###################
resource "proxmox_virtual_environment_download_file" "pardofelis" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pardofelis"

  url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

# Worker only node ###################
resource "proxmox_virtual_environment_download_file" "su" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "su"

  url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}
