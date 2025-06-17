resource "proxmox_vm_qemu" "elysia-pardofelis" {
  name         = "elysia-pardofelis"
  target_node  = "Cipher"
  vmid         = 140 # Explicit VM ID to prevent conflicts

  agent    = 1
  os_type  = "cloud-init"
  onboot   = true
  startup  = "order=3,up=60,down=60"

  cpu {
    cores  = 1
  }
  memory = 2560

  # Boot configuration
  bootdisk = "scsi0"
  boot     = "order=scsi0;ide2"

  # New disks block syntax for provider 3.x
  disks {
    scsi {
      scsi0 {
        disk {
          size     = "32G"
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
  ipconfig0  = "ip=10.42.0.13/24,gw=10.42.0.1"
  nameserver = "1.1.1.1 8.8.8.8"
}
