variable "proxmox_url" {
  type        = string
  description = "Proxmox VE API URL"
}

variable "proxmox_user" {
  type        = string
  description = "Proxmox VE username"
}

variable "proxmox_password" {
  sensitive   = true
  type        = string
  description = "Proxmox VE password"
}

variable "k3s_config" {
  sensitive = true
  type = object({
    cluster_vip   = string
    cluster_token = string
    k3s_version   = string
  })
  default = {
    cluster_vip   = "192.168.8.20"
    cluster_token = "your-k3s-cluster-token-here"
    k3s_version   = "v1.31.4+k3s1"
  }
  description = "K3s cluster configuration"
}

variable "p4d_config" {
  type = object({
    enabled      = bool
    image        = string
    storage_size = string
    node_port    = number
  })
  default = {
    enabled      = false
    image        = "perforce/helix-core-server:latest"
    storage_size = "50Gi"
    node_port    = 31666
  }
  description = "Perforce Helix Core (p4d) deployment configuration"
}

# Storage where Proxmox snippets are stored (usually 'local')
variable "proxmox_snippets_storage" {
  type        = string
  default     = "local"
  description = "Proxmox storage name used for snippets (e.g., 'local')."
}

# SSH connection info to Proxmox host for uploading snippets and importing disks
variable "proxmox_ssh_host" {
  type        = string
  default     = null
  description = "Proxmox host/IP for SSH (set to enable uploads/import)."
}

variable "proxmox_ssh_user" {
  type        = string
  default     = null
  description = "SSH user for Proxmox (e.g., 'root')."
}

variable "proxmox_ssh_private_key_path" {
  type        = string
  default     = null
  description = "Path to SSH private key for Proxmox access."
}


# Name of an existing Proxmox VM template prepared from a cloud-init image
# Follow the provider's cloud-init getting started guide to create it.
variable "proxmox_vm_template" {
  type        = string
  default     = "ubuntu-24.04-cloudinit-template"
  description = "Cloud-init enabled VM template name to clone for each node."
}
