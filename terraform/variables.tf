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

variable "proxmox_vm_template" {
  type        = string
  description = "Cloud-init enabled VM template name to clone for each node."
}

# Optional: Proxmox storage name for snippets (defaults to 'local' in module if unset)
variable "proxmox_snippets_storage" {
  type        = string
  default     = null
  description = "Proxmox storage name used for snippets (e.g., 'local')."
}

# Optional: SSH details to upload snippet files to Proxmox host
variable "proxmox_ssh_host" {
  type        = string
  default     = null
  description = "Proxmox host/IP for SSH to upload snippets."
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
