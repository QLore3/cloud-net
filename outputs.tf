output "bucket_name" {
  description = "Object Storage bucket name"
  value       = yandex_storage_bucket.homework.bucket
}

output "image_url" {
  description = "Public URL of the image in the bucket"
  value       = "https://storage.yandexcloud.net/${yandex_storage_bucket.homework.bucket}/${yandex_storage_object.image.key}"
}

output "lamp_group_instances" {
  description = "Instance IDs in the group"
  value       = yandex_compute_instance_group.lamp.instances[*].instance_id
}

output "load_balancer_address" {
  description = "External IP of the network load balancer"
  value       = yandex_lb_network_load_balancer.lamp.listener[*].external_address_spec[*].address
}
