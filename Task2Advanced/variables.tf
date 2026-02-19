variable "service_account_key_file" {
  description = "Path to the service account key file for Yandex Cloud"
  type        = string
  default     = null # Optional if provided via env vars
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  default     = null
}

variable "folder_id" {
  description = "Yandex Folder ID"
  type        = string
  default     = null
}

variable "zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "vm_name" {
  description = "Name for the VM instance"
  type        = string
  default     = "test-vm-from-ci"
}

variable "subnet_id" {
  description = "Subnet ID for the VM"
  type        = string
  default     = "dummy-subnet-id"
}

variable "ssh_public_key" {
  description = "Public SSH key for VM access"
  type        = string
  default     = "ssh-rsa dummy-key"
}
