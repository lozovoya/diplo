resource "yandex_compute_instance" "kube-master" {
  name        = "kube-master-${terraform.workspace}"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size     = 50
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.public-a.id
    ip_address     = ""
    nat            = true
    nat_ip_address = ""

  }

  metadata = {
    ssh-keys = "admin:${var.ssh_key}"
  }


}

resource "yandex_compute_instance" "kube-node" {
  name        = "kube-node-${count.index}-${terraform.workspace}"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  count       = 2
  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size     = 50
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.public-a.id
    ip_address     = ""
    nat            = true
    nat_ip_address = ""
  }

  metadata = {
    ssh-keys = "admin:${var.ssh_key}"
  }
}