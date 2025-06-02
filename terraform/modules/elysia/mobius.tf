resource "proxmox_virtual_environment_vm" "mobius" {
  name = "mobius"
  node_name = "elysia-mobius"

  agent {
    enabled = false
  }
  stop_on_destroy = true

  startup {
    order = "3"
    up_delay = "60"
    down_delay = "60"
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "local-lvm"
    file_id = proxmox_virtual_environment_download_file.mobius.image.id
    interface = "virtio0"
    iothread = true
    discard = "on"
    size = "32G"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.42.0.120"
        gateway = "10.42.0.1"
      }
    }

    user_account {
      username = "kubernetes"
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  network_device {
    bridge = "br0"
  }
}
