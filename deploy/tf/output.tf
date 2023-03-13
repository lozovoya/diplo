
output "master" {
  value = yandex_compute_instance.kube-master.network_interface[0].nat_ip_address
}

output "node" {
  value = yandex_compute_instance.kube-node[*].network_interface[0].nat_ip_address
}