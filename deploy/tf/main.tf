terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.8"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-dsfdsfdsfds8768767823"
    region     = "ru-central1"
    key        = "tfstates/netology-diploma.tfstate"
    access_key = "YCAJEL4EDyKE5MBJQoN-vK8D7"
    secret_key = "YCNELhVlUUkh3huPtb1xBxixXy_kY0tPahxPYZ2A"
    skip_region_validation      = true
    skip_credentials_validation = true
  }

}


provider "yandex" {
  zone = "ru-central1-a"
  #service_account_key_file = "/Users/Andrey_Lozovoy/.yc/key.json"
  service_account_key_file = "${var.ya_key}"
  cloud_id                 = "$b1gjtddi41p742jcni7p"
}






