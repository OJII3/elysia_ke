resource "proxmox_vm_qemu" "elysia-kevin" {
  name         = "elysia-kevin"
  target_node  = "Cipher"
  vmid         = 120 # Explicit VM ID to prevent conflicts

  agent    = 0
  os_type  = "cloud-init"
  onboot   = true
  startup  = "order=3,up=60,down=60"

  cpu {
    cores  = 2
  }
  memory = 4096

  # Boot configuration
  bootdisk = "scsi0"
  boot     = "order=scsi0;ide2"

  # New disks block syntax for provider 3.x
  disks {
    scsi {
      scsi0 {
        disk {
          size     = "50G"
          storage  = "local"
        }
      }
    }
    ide {
      ide1 {
        cdrom {
          iso = local.fedora_coreos_iso
        }
      }
    }
  }

  network {
    id = 0
    bridge = "br0"
    model  = "virtio"
  }

  # Cloud-init configuration
  ciuser     = "kubernetes"
  sshkeys    = trimspace(data.local_file.ssh_public_key.content)
  ipconfig0  = "ip=10.42.0.11/24,gw=10.42.0.1"
  nameserver = "1.1.1.1 8.8.8.8"
  cicustom   = "user=local:snippets/elysia-kevin-user-data.yml"
  
  # Ensure cloud-init file is created before VM
  depends_on = [local_file.elysia_kevin_user_data]
}
