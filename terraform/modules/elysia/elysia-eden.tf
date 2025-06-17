resource "proxmox_vm_qemu" "elysia-eden" {
  name         = "elysia-eden"
  target_node  = "Cipher"
  vmid         = 110 # Explicit VM ID to prevent conflicts

  agent    = 0
  os_type  = "cloud-init"
  onboot   = true
  startup  = "order=3,up=60,down=60"

  cpu {
    cores  = 4
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
      ide2 {
        cdrom {
          iso = local.fedora_coreos_iso
        }
        # cloudinit {
        #   storage = "local-lvm"
        # }
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
  ipconfig0  = "ip=10.42.0.10/24,gw=10.42.0.1"
}
