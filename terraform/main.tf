module "elysia" {
  source = "./modules/elysia"

  proxmox_password    = var.proxmox_password
  proxmox_user        = var.proxmox_user
  proxmox_url         = var.proxmox_url
  proxmox_vm_template = var.proxmox_vm_template

  # Optional pass-throughs
  proxmox_snippets_storage   = coalesce(var.proxmox_snippets_storage, "local")
  proxmox_ssh_host           = var.proxmox_ssh_host
  proxmox_ssh_user           = var.proxmox_ssh_user
  proxmox_ssh_private_key_path = var.proxmox_ssh_private_key_path
}
