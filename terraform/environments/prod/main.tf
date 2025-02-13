locals {
  base_network = var.base_network
  gateway_ip   = var.gateway_ip
}

module "talos_control_plane" {
  source = "../../modules/vm"
  count  = 1

  hostname     = "k8s-admin-${count.index + 1}"
  target_node  = var.target_node
  vmid         = 500 + count.index
  
  # Hardware configuration
  memory       = 6144
  cores        = 2
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

module "talos_worker" {
  source = "../../modules/vm"
  count  = 3

  hostname     = "k8s-worker-${count.index + 1}"
  target_node  = var.target_node
  vmid         = 600 + count.index
  
  # Hardware configuration
  memory       = 6144
  cores        = 2
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
  vm_state      = var.vm_state

  # Cloud-init settings
  ssh_public_keys = file(var.ssh_public_key)
}
/*
module "namespace" {
  source = "../../modules/namespace"
  depends_on = [module.talos_control_plane, module.talos_worker]
}

module "pv" {
  source = "../../modules/pv"
  nfs_server = var.nfs_server
  nfs_path = var.nfs_path
  gitea_namespace = module.namespace.gitea_namespace
  vault_namespace = module.namespace.vault_namespace
  depends_on = [module.talos_control_plane, module.talos_worker]
}

module "nfs_provisioner" {
  source = "../../modules/nfs_provisioner"
  namespace = module.namespace.storage_namespace
  nfs_server = var.nfs_server
  nfs_path = var.nfs_path
  values = var.nfs_provisioner_values
  depends_on = [module.talos_control_plane, module.talos_worker]
}

module "storage_class" {
  source = "../../modules/storage_class"
  nfs_server = var.nfs_server
  nfs_path = var.nfs_path
  depends_on = [module.talos_control_plane, module.talos_worker]
}

module "helm_release" {
  source = "../../modules/helm_release"
  argocd_namespace = module.namespace.argocd_namespace
  gitea_namespace = module.namespace.gitea_namespace
  monitoring_namespace = module.namespace.monitoring_namespace
  vault_namespace = module.namespace.vault_namespace
  storage_namespace = module.namespace.storage_namespace
  media_namespace = module.namespace.media_namespace
  security_namespace = module.namespace.security_namespace
  management_namespace = module.namespace.management_namespace
  repository = {
    argocd = "https://argoproj.github.io/argo-helm"
    gitea = "https://dl.gitea.io/charts/"
    vault = "https://helm.releases.hashicorp.com"
    postgresql = "https://charts.bitnami.com/bitnami"
  }
  values = {
    argocd = "${path.module}/values/argocd-values.yaml"
    gitea = "${path.module}/values/gitea-values.yaml"
    vault = "${path.module}/values/vault-values.yaml"
    postgresql = var.postgresql_values
  }
  depends_on = [module.talos_control_plane, module.talos_worker]
}
*/