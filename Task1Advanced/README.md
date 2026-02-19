# Terraform VM Module (Task 1 Advanced)

Этот репозиторий содержит универсальный Terraform модуль для создания виртуальной машины в Yandex Cloud с дополнительным диском, а также конфигурации для трех окружений: `dev`, `stage`, `prod`.

## Структура

```
Task1Advanced/
├── modules/
│   └── vm/             # Универсальный модуль VM
├── envs/
│   ├── dev/            # Конфигурация для Dev окружения
│   ├── stage/          # Конфигурация для Stage окружения
│   └── prod/           # Конфигурация для Prod окружения
└── README.md
```

## Модуль `modules/vm`

Модуль создает:
- Виртуальную машину (`yandex_compute_instance`)
- Вторичный диск (`yandex_compute_disk`) и подключает его к ВМ
- Настраивает сеть и SSH доступ

### Входные переменные (Variables)

| Имя | Описание | Тип | По умолчанию |
|---|---|---|---|
| `vm_name` | Имя виртуальной машины | string | - |
| `vm_cpu` | Количество ядер CPU | number | - |
| `vm_ram` | Объем RAM в ГБ | number | - |
| `boot_disk_image_id` | ID образа загрузочного диска | string | - |
| `boot_disk_size` | Размер загрузочного диска (ГБ) | number | 10 |
| `secondary_disk_size` | Размер дополнительного диска (ГБ) | number | 10 |
| `subnet_id` | ID подсети | string | - |
| `ssh_public_key` | Публичный SSH ключ | string | - |
| `zone` | Зона доступности | string | ru-central1-a |

### Выходы (Outputs)

| Имя | Описание |
|---|---|
| `vm_id` | ID созданной виртуальной машины |
| `vm_external_ip` | Внешний IP адрес |
| `vm_internal_ip` | Внутренний IP адрес |
| `disk_id` | ID дополнительного диска |

## Запуск окружений

Для запуска конфигурации необходимо перейти в соответствующую директорию (`envs/dev`, `envs/stage` или `envs/prod`) и выполнить команды Terraform.

### Предварительные требования

- Установленный Terraform
- Настроенный провайдер Yandex Cloud (через переменные окружения или `~/.yc`)

### Dev

```bash
cd envs/dev
terraform init
terraform apply -var-file=terraform.tfvars
```

### Stage

```bash
cd envs/stage
terraform init
terraform apply -var-file=terraform.tfvars
```

### Prod

```bash
cd envs/prod
terraform init
terraform apply -var-file=terraform.tfvars
```

## Конфигурации окружений

- **Dev**: 2 CPU, 2 GB RAM, 10 GB Secondary Disk
- **Stage**: 4 CPU, 4 GB RAM, 20 GB Secondary Disk
- **Prod**: 8 CPU, 8 GB RAM, 50 GB Secondary Disk
