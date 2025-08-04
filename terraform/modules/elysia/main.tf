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
  fedora_coreos_iso = "local:iso/flatcar_production_iso_image.iso"
}

# Cloud-init templates for k3s nodes
resource "local_file" "elysia_eden_user_data" {
  content = templatefile("${path.module}/cloud-init/elysia-eden-user-data.yml", {
    k3s_token      = var.k3s_config.cluster_token
    k3s_version    = var.k3s_config.k3s_version
    cluster_vip    = var.k3s_config.cluster_vip
    node_ip        = "10.42.0.10"
    ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
  })
  filename = "/tmp/elysia-eden-user-data.yml"
}

resource "local_file" "elysia_kevin_user_data" {
  content = templatefile("${path.module}/cloud-init/elysia-control-plane-user-data.yml", {
    k3s_token      = var.k3s_config.cluster_token
    k3s_version    = var.k3s_config.k3s_version
    cluster_vip    = var.k3s_config.cluster_vip
    node_ip        = "10.42.0.11"
    ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
  })
  filename = "/tmp/elysia-kevin-user-data.yml"
}

resource "local_file" "elysia_mobius_user_data" {
  content = templatefile("${path.module}/cloud-init/elysia-control-plane-user-data.yml", {
    k3s_token      = var.k3s_config.cluster_token
    k3s_version    = var.k3s_config.k3s_version
    cluster_vip    = var.k3s_config.cluster_vip
    node_ip        = "10.42.0.12"
    ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
  })
  filename = "/tmp/elysia-mobius-user-data.yml"
}

resource "local_file" "elysia_pardofelis_user_data" {
  content = templatefile("${path.module}/cloud-init/elysia-worker-user-data.yml", {
    k3s_token      = var.k3s_config.cluster_token
    k3s_version    = var.k3s_config.k3s_version
    cluster_vip    = var.k3s_config.cluster_vip
    node_ip        = "10.42.0.13"
    ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
  })
  filename = "/tmp/elysia-pardofelis-user-data.yml"
}

resource "local_file" "elysia_su_user_data" {
  content = templatefile("${path.module}/cloud-init/elysia-worker-user-data.yml", {
    k3s_token      = var.k3s_config.cluster_token
    k3s_version    = var.k3s_config.k3s_version
    cluster_vip    = var.k3s_config.cluster_vip
    node_ip        = "10.42.0.14"
    ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
  })
  filename = "/tmp/elysia-su-user-data.yml"
}


