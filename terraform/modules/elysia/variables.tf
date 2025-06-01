variable "proxmox_config" {
  sensitive = true
  type = object({
    endpoint = string
    username = string
    password = string
    pub_key_file = string
  })
  default = {
    endpoint = "https://cipher:8006"
    username = "proxmox username"
    password = "proxmox password"
    pub_key_file = ""
  }
}
