## Namespaces
/*
output "argocd_namespace" {
  value = module.namespace.argocd_namespace
}

output "gitea_namespace" {
  value = module.namespace.gitea_namespace
}

output "monitoring_namespace" {
  value = module.namespace.monitoring_namespace
}

output "vault_namespace" {
  value = module.namespace.vault_namespace
}

output "storage_namespace" {
  value = module.namespace.storage_namespace
}

output "media_namespace" {
  value = module.namespace.media_namespace
}

output "security_namespace" {
  value = module.namespace.security_namespace
}

output "management_namespace" {
  value = module.namespace.management_namespace
}
*/
output "master_node_details" {
  description = "Details of the talos master nodes"
  value = {
    for idx, vm in module.talos_control_plane : "control-plane-${idx + 1}" => {
      name = vm.name
      vmid = vm.vmid
    }
  }
}

output "master_ips" {
  description = "IP addresses of the master nodes"
  value       = module.talos_control_plane[*].ip_address
}

output "worker_node_details" {
  description = "Details of the talos worker nodes"
  value = {
    for idx, vm in module.talos_worker : "worker-${idx + 1}" => {
      name = vm.name
      vmid = vm.vmid
    }
  }
}

output "worker_ips" {
  description = "IP addresses of the worker nodes"
  value       = module.talos_worker[*].ip_address
}

output "note" {
  description = "Note about VM access"
  value       = "The VMs have been created with DHCP enabled. Please check your DHCP server or router to find their assigned IP addresses."
}
