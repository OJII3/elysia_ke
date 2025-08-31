variable "proxmox_config" {
  sensitive = true
  type = object({
    endpoint = string
    username = string
    password = string
  })
  default = {
    endpoint = "http://cipher:8006/api2/json"
    username = "xxxxxxxx"
    password = "xxxxxxxxxxxxxxx"
  }
  description = "Proxmox VE connection configuration"
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
