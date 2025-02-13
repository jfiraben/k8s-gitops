locals {
  base_network = var.base_network
  gateway_ip   = var.gateway_ip
}

module "talos_master" {
  source = "../../modules/vm"
  count  = 2

  hostname     = "talos-admin-${count.index + 1}"
  target_node  = var.target_node
  vmid         = 200 + count.index
  
  # Hardware configuration
  memory       = 12288  # 2GB RAM
  cores        = 4
  sockets      = 1
  
  # Storage configuration
  storage_pool = var.storage_pool
  disk_size    = "100G"
  
  # Network configuration
  network_bridge = "vmbr0"
  network_model  = "virtio"
  ipconfig      = "ip=dhcp"
  
  # Boot and SCSI configuration
  boot          = "order=scsi0;net0"
  bootdisk      = "ide2"
  scsihw        = "virtio-scsi-pci"
  vm_state      = var.vm_state

  # Cloud-init settings
  ssh_public_keys = file(var.ssh_public_key)
}

module "talos_node" {
  source = "../../modules/vm"
  count  = 3

  hostname     = "talos-worker-${count.index + 1}"
  target_node  = var.target_node
  vmid         = 300 + count.index
  
  # Hardware configuration
  memory       = 12288  # 6GB RAM
  cores        = 4
  sockets      = 1
  
  # Storage configuration
  storage_pool = var.storage_pool
  disk_size    = "100G"
  
  # Network configuration
  network_bridge = "vmbr0"
  network_model  = "virtio"
  ipconfig      = "ip=dhcp"
  
  # Boot and SCSI configuration
  boot          = "order=ide2;scsi0;net0"
  bootdisk      = "scsi0"
  scsihw        = "virtio-scsi-pci"

  # Cloud-init settings
  ssh_public_keys = file(var.ssh_public_key)
}
