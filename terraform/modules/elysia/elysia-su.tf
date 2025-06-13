resource "proxmox_virtual_environment_vm" "elysia-su" {
  name      = "elysia-su"
  node_name = "cipher"

  agent {
    enabled = true
  }
  stop_on_destroy = true

  startup {
    order      = "4"
    up_delay   = "60"
    down_delay = "60"
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 3072
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.flatcar_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 40
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.42.0.20/24"
        gateway = "10.42.0.1"
      }
    }
    
    user_account {
      username = "kubernetes"
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  network_device {
    bridge = "br0"
  }
}
