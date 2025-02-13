locals {
  base_network = var.base_network
  gateway_ip   = var.gateway_ip
}

module "k3s_master" {
  source = "../../modules/vm"
  count  = 1  # One admin node

  hostname     = "rke2-admin-${count.index + 1}"
  target_node  = var.target_node
  vmid         = 400 + count.index
  
  # Hardware configuration
  memory       = 2048  # 2GB RAM
  cores        = 1
  sockets      = 1
  
  # Storage configuration
  storage_pool = var.storage_pool
  disk_size    = "40G"
  
  # Network configuration
  network_bridge = "vmbr0"
  network_model  = "virtio"
  ipconfig      = "ip=dhcp"
  
  # Boot and SCSI configuration
  boot          = "c"
  bootdisk      = "scsi0"
  scsihw        = "virtio-scsi-pci"
  vm_state      = var.vm_state
  
  # Display configuration
  vga           = "serial0"
  serial0       = "socket"

  # Cloud-init settings
  ciuser        = var.vm_user
  ssh_public_keys = file(var.ssh_public_key)
}

module "k3s_node" {
  source = "../../modules/vm"
  count  = 5  # Five worker nodes

  hostname     = "rke2-${count.index + 1}"
  target_node  = var.target_node
  vmid         = 410 + count.index
  
  # Hardware configuration
  memory       = 6144  # 6GB RAM
  cores        = 4
  sockets      = 1
  
  # Storage configuration
  storage_pool = var.storage_pool
  disk_size    = "80G"
  
  # Network configuration
  network_bridge = "vmbr0"
  network_model  = "virtio"
  ipconfig      = "ip=dhcp"
  
  # Boot and SCSI configuration
  boot          = "c"
  bootdisk      = "scsi0"
  scsihw        = "virtio-scsi-pci"
  
  # Display configuration
  vga           = "serial0"
  serial0       = "socket"

  # Cloud-init settings
  ciuser        = var.vm_user
  ssh_public_keys = file(var.ssh_public_key)

  # Make sure all master nodes are created first
  depends_on = [
    module.k3s_master
  ]
}
