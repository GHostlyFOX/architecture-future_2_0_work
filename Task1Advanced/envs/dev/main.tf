module "vm" {
  source = "../../modules/vm"

  vm_name             = var.vm_name
  vm_cpu              = var.vm_cpu
  vm_ram              = var.vm_ram
  boot_disk_image_id  = var.boot_disk_image_id
  boot_disk_size      = var.boot_disk_size
  secondary_disk_size = var.secondary_disk_size
  subnet_id           = var.subnet_id
  ssh_public_key      = var.ssh_public_key
  zone                = var.zone
}
