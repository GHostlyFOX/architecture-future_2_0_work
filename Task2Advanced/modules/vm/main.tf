terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_disk" "secondary" {
  name     = "${var.vm_name}-secondary-disk"
  type     = "network-hdd"
  zone     = var.zone
  size     = var.secondary_disk_size
}

resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = var.vm_cpu
    memory = var.vm_ram
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_image_id
      size     = var.boot_disk_size
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.secondary.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}
