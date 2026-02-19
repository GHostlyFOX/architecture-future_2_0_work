terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-state-bucket"  # Замените на имя вашего бакета
    region     = "ru-central1"
    key        = "dev/terraform.tfstate"
    access_key = "" # Будет взят из переменных окружения AWS_ACCESS_KEY_ID
    secret_key = "" # Будет взят из переменных окружения AWS_SECRET_ACCESS_KEY

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
