output "vm_external_ip" {
  description = "External IP address of the deployed VM"
  value       = module.vm_instance.vm_external_ip
}
