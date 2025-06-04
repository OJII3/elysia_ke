resource "proxmox_virtual_environment_vm" "elysia-pardofelis" {
  name      = "elysia-pardofelis"
  node_name = "pardofelis"

  agent {
    enabled = true
  }
  stop_on_destroy = true

  startup {
    order      = "2"
    up_delay   = "30"
    down_delay = "30"
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.pardofelis.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 30
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.42.0.100/24"
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

