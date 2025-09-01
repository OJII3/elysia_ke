resource "proxmox_vm_qemu" "elysia-eden" {
  name        = "elysia-eden"
  target_node = "Cipher"
  vmid        = 110 # Explicit VM ID to prevent conflicts

  # clone      = var.proxmox_vm_template

  agent   = 0
  os_type = "cloud-init"
  onboot  = true
  # boot    = "order=scsi0"

  cpu {
    cores = 2
  }
  memory = 4096

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local"
          size    = "2G" 
        }
      }
    }
    ide {
      # ide1 {
      #   cloudinit {
      #     storage = "local"
      #   }
      # }
      ide2 {
        cdrom {
          iso = local.iso_path
        }
      }
    }
  }

  # Cloud-init configuration
  # ciuser     = "kubernetes"
  # sshkeys    = local.ssh_public_key
  # ipconfig0  = "ip=192.168.8.10/24,gw=192.168.8.1"
  # nameserver = "192.168.8.1 1.1.1.1"
  # cicustom   = "user=${var.proxmox_snippets_storage}:snippets/elysia-eden-user-data.yml"

  # depends_on = [
  #   local_file.elysia_eden_user_data,
  #   null_resource.upload_snippets,
  # ]
}
