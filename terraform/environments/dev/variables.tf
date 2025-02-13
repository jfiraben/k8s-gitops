variable "target_node" {
  description = "The Proxmox node to create the VMs on"
  type        = string
  default     = "js-1"  # Change this to your Proxmox node name
}

variable "proxmox_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "The ID of the Proxmox API token"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "The secret of the Proxmox API token"
  type        = string
  sensitive   = true
}

# Optional: Override these variables if needed
variable "ssh_public_key" {
  description = "The SSH public key to add to the VMs"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "network_bridge" {
  description = "The network bridge to use for the VMs"
  type        = string
  default     = "vmbr0"
}

variable "storage_pool" {
  description = "The storage pool to use for the VMs"
  type        = string
  default     = "local-lvm"
}

variable "base_network" {
  description = "The base network CIDR for the VMs"
  type        = string
  default     = "192.168.0.0/22"
}

variable "vm_user" {
  description = "The username to create in the VMs"
  type        = string
  default     = "jordan"  # Change this to your desired username
}

variable "vm_state" {
  description = "State of the VM after creation (running or stopped)"
  type        = string
  default     = "stopped"
}

variable "gateway_ip" {
  description = "The gateway IP for the VMs"
  type        = string
  default     = "192.168.4.1"
}