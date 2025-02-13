output "master_node_details" {
  description = "Details of the talos master nodes"
  value = {
    for idx, vm in module.talos_master : "master-${idx + 1}" => {
      name = vm.name
      vmid = vm.vmid
    }
  }
}

output "master_ips" {
  description = "IP addresses of the master nodes"
  value       = module.talos_master[*].ip_address
}

output "worker_node_details" {
  description = "Details of the talos worker nodes"
  value = {
    for idx, vm in module.talos_node : "node-${idx + 1}" => {
      name = vm.name
      vmid = vm.vmid
    }
  }
}

output "worker_ips" {
  description = "IP addresses of the worker nodes"
  value       = module.talos_node[*].ip_address
}

output "note" {
  description = "Note about VM access"
  value       = "The VMs have been created with DHCP enabled. Please check your DHCP server or router to find their assigned IP addresses."
}