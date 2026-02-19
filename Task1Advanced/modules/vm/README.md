# VM Module

Этот модуль создает виртуальную машину Yandex Cloud с присоединенным дополнительным диском.

## Resources

- `yandex_compute_instance.vm`: Виртуальная машина.
- `yandex_compute_disk.secondary`: Дополнительный диск.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `vm_name` | Name of the VM instance | string | - | yes |
| `vm_cpu` | Number of CPU cores | number | - | yes |
| `vm_ram` | Amount of RAM in GB | number | - | yes |
| `boot_disk_image_id` | ID of the boot disk image | string | - | yes |
| `boot_disk_size` | Size of the boot disk in GB | number | 10 | no |
| `secondary_disk_size` | Size of the secondary disk in GB | number | 10 | no |
| `subnet_id` | ID of the subnet | string | - | yes |
| `ssh_public_key` | Public SSH key | string | - | yes |
| `zone` | Availability zone | string | ru-central1-a | no |

## Outputs

| Name | Description |
|------|-------------|
| `vm_id` | The ID of the VM |
| `vm_external_ip` | The external IP address of the VM |
| `vm_internal_ip` | The internal IP address of the VM |
| `disk_id` | The ID of the secondary disk |
