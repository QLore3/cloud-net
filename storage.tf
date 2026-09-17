resource "yandex_iam_service_account" "storage" {
  name        = "storage-sa"
  description = "Service account for Object Storage access"
}

resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.storage.id}"
}

resource "yandex_iam_service_account_static_access_key" "storage" {
  service_account_id = yandex_iam_service_account.storage.id
  description        = "Static access key for Object Storage"
}

resource "yandex_storage_bucket" "homework" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.storage.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage.secret_key
}

resource "yandex_storage_object" "image" {
  bucket     = yandex_storage_bucket.homework.bucket
  key        = "image.jpg"
  source     = "${path.module}/files/image.jpg"
  access_key = yandex_iam_service_account_static_access_key.storage.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage.secret_key
}
