terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_config.endpoint
  pm_user         = var.proxmox_config.username
  pm_password     = var.proxmox_config.password
  pm_tls_insecure = true
}

# Common ISO file for all VMs
locals {
  fedora_coreos_iso = "local:iso/flatcar_production_iso_image.iso"
  ssh_public_key    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICirSl3nlg3z3VID3ondlBDy7teYu74pnRPFhvj2LfkH"
}


# Cloud-init templates for k3s nodes
resource "local_file" "elysia_eden_user_data" {
  content = sensitive(templatefile("${path.module}/cloud-init/elysia-eden-user-data.yml", {
    k3s_token   = var.k3s_config.cluster_token
    k3s_version = var.k3s_config.k3s_version
    cluster_vip = var.k3s_config.cluster_vip
    node_ip     = "192.168.8.10"
    p4d_enabled = var.p4d_config.enabled
    p4d_manifest = indent(6, templatefile("${path.module}/cloud-init/perforce-p4d.yml", {
      p4d_image     = var.p4d_config.image
      p4d_storage   = var.p4d_config.storage_size
      p4d_node_port = var.p4d_config.node_port
    }))
  }))
  filename = "/tmp/elysia-eden-user-data.yml"
}

resource "local_file" "elysia_mobius_user_data" {
  content = sensitive(templatefile("${path.module}/cloud-init/elysia-control-plane-user-data.yml", {
    k3s_token   = var.k3s_config.cluster_token
    k3s_version = var.k3s_config.k3s_version
    cluster_vip = var.k3s_config.cluster_vip
    node_ip     = "192.168.8.11"
  }))
  filename = "/tmp/elysia-mobius-user-data.yml"
}

resource "local_file" "elysia_pardofelis_user_data" {
  content = sensitive(templatefile("${path.module}/cloud-init/elysia-control-plane-user-data.yml", {
    k3s_token   = var.k3s_config.cluster_token
    k3s_version = var.k3s_config.k3s_version
    cluster_vip = var.k3s_config.cluster_vip
    node_ip     = "192.168.8.12"
  }))
  filename = "/tmp/elysia-pardofelis-user-data.yml"
}
