module "elysia" {
  source = "../modules/elysia"

  proxmox_config = {
    endpoint = var.proxmox_config.endpoint
    username = var.proxmox_config.username
    password = var.proxmox_config.password
  }
}

