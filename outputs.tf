output "nat_public_ip" {
  description = "Public IP address of NAT instance"
  value       = yandex_compute_instance.nat.network_interface[0].nat_ip_address
}

output "public_vm_ip" {
  description = "Public IP address of public VM"
  value       = yandex_compute_instance.public.network_interface[0].nat_ip_address
}
