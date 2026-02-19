output "vm_id" {
  description = "The ID of the VM"
  value       = yandex_compute_instance.vm.id
}

output "vm_external_ip" {
  description = "The external IP address of the VM"
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "vm_internal_ip" {
  description = "The internal IP address of the VM"
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "disk_id" {
  description = "The ID of the secondary disk"
  value       = yandex_compute_disk.secondary.id
}
