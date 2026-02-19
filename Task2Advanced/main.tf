# Пример использования модуля из Task1Advanced
# Этот модуль создаст ВМ в дефолтной конфигурации

module "vm_instance" {
  source              = "./modules/vm"
  vm_name             = var.vm_name
  vm_cpu              = 2
  vm_ram              = 2
  boot_disk_image_id  = "fd827b91d52655555555" # Example ID
  boot_disk_size      = 10
  secondary_disk_size = 10
  subnet_id           = var.subnet_id
  ssh_public_key      = var.ssh_public_key
  zone                = var.zone
}
