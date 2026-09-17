variable "yc_token" {
  description = "Yandex Cloud IAM token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Yandex Cloud availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "bucket_name" {
  description = "Object Storage bucket name"
  type        = string
}

variable "lamp_image_id" {
  description = "LAMP image ID"
  type        = string
  default     = "fd827b91d99psvq5fjit"
}
