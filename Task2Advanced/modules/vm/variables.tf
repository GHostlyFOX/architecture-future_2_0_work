variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "vm_cpu" {
  description = "Number of CPU cores for the VM"
  type        = number
}

variable "vm_ram" {
  description = "Amount of RAM in GB for the VM"
  type        = number
}

variable "boot_disk_image_id" {
  description = "ID of the image for the boot disk"
  type        = string
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 10
}

variable "secondary_disk_size" {
  description = "Size of the secondary disk in GB"
  type        = number
  default     = 10
}

variable "subnet_id" {
  description = "ID of the subnet to connect the VM to"
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key for access to the VM"
  type        = string
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}
