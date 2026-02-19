# Task 2 Advanced: Интеграция с CI/CD и удалённым хранением состояния

Этот проект демонстрирует настройку Terraform с использованием удаленного backend (S3/Yandex Object Storage) и автоматизацию развертывания через GitLab CI/CD.

## Структура

```
Task2Advanced/
├── ci-cd/
│   └── .gitlab-ci.yml  # Конфигурация пайплайна GitLab CI
├── modules/
│   └── vm/             # Копия модуля VM из Task 1 (для самодостаточности примера)
├── backend.tf          # Конфигурация S3 backend
├── main.tf             # Описание инфраструктуры (вызов модуля VM)
├── provider.tf         # Провайдер Yandex Cloud
├── variables.tf        # Переменные
└── outputs.tf          # Выходы
```

## Настройка Backend (Yandex Object Storage)

Для работы удаленного состояния необходимо создать бакет в Yandex Object Storage и сервисный аккаунт с правами на запись.

1.  Создайте бакет (например, `terraform-state-bucket`).
2.  Создайте сервисный аккаунт и статический ключ доступа (Access Key и Secret Key).
3.  В файле `backend.tf` указан бакет `bucket = "terraform-state-bucket"`. При использовании измените это значение на имя вашего бакета.

## Настройка CI/CD (GitLab CI)

Пайплайн описан в файле `ci-cd/.gitlab-ci.yml`.

### Переменные окружения (CI/CD Variables)

В настройках репозитория GitLab (Settings -> CI/CD -> Variables) необходимо добавить следующие переменные:

| Имя переменной | Описание | Тип |
|---|---|---|
| `ACCESS_KEY` | Access Key ID для доступа к S3 бакету (хранение state) | Variable (Masked) |
| `SECRET_KEY` | Secret Access Key для доступа к S3 бакету | Variable (Masked) |
| `YC_TOKEN` | OAuth токен или IAM токен для аутентификации провайдера Yandex | Variable (Masked) |
| `YC_CLOUD_ID` | ID облака Yandex Cloud | Variable |
| `YC_FOLDER_ID` | ID каталога Yandex Cloud | Variable |

**Примечание:** Terraform автоматически подхватывает переменные `YC_TOKEN`, `YC_CLOUD_ID`, `YC_FOLDER_ID` для настройки провайдера Yandex, если они экспортированы в окружении.

### Этапы пайплайна

1.  **Init**: Инициализация Terraform.
    *   Команда: `terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"`
    *   Здесь мы передаем ключи доступа к backend динамически, чтобы не хранить их в коде.

2.  **Plan**: Создание плана изменений.
    *   Команда: `terraform plan -out=tfplan`
    *   Артефакт: файл `tfplan`, который передается на следующий этап.

3.  **Apply**: Применение изменений.
    *   Команда: `terraform apply "tfplan"`
    *   Запуск: **Ручной** (manual trigger) по кнопке в интерфейсе GitLab.
    *   Ограничение: Только для ветки `main`.

## Безопасность

*   Файл состояния `terraform.tfstate` хранится в защищенном S3 бакете, а не в репозитории.
*   Секреты (ключи доступа) не хранятся в коде, а передаются через переменные окружения CI/CD.
*   Применение изменений требует ручного подтверждения (`when: manual`), что предотвращает случайные изменения продовой инфраструктуры.
