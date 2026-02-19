variable "vm_name" {
  type = string
}

variable "vm_cpu" {
  type = number
}

variable "vm_ram" {
  type = number
}

variable "boot_disk_image_id" {
  type = string
}

variable "boot_disk_size" {
  type = number
}

variable "secondary_disk_size" {
  type = number
}

variable "subnet_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}
