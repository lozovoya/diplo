resource "yandex_vpc_network" "netology" {
  name = "netology-${terraform.workspace}"

}

resource "yandex_vpc_subnet" "public-a" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
  name = "public-a-${terraform.workspace}"

}

resource "yandex_vpc_subnet" "private-a" {
  v4_cidr_blocks = ["192.168.11.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
  name = "private-a-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "public-b" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.netology.id
  name = "public-b-${terraform.workspace}"

}

resource "yandex_vpc_subnet" "private-b" {
  v4_cidr_blocks = ["192.168.21.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.netology.id
  name = "private-b-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "public-c" {
  v4_cidr_blocks = ["192.168.30.0/24"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.netology.id
  name = "public-c-${terraform.workspace}"

}

resource "yandex_vpc_subnet" "private-c" {
  v4_cidr_blocks = ["192.168.31.0/24"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.netology.id
  name = "private-c-${terraform.workspace}"
}

resource "yandex_vpc_security_group" "netology-sg" {
  name        = "netology-sg-${terraform.workspace}"
  description = "SSH and HTTP/HTTPS"
  network_id  = yandex_vpc_network.netology.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule description 1"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}