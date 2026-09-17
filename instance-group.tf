resource "yandex_iam_service_account" "instance_group" {
  name        = "ig-sa"
  description = "Service account for instance group"
}

resource "yandex_resourcemanager_folder_iam_member" "ig_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.instance_group.id}"
}

resource "yandex_compute_instance_group" "lamp" {
  name               = "lamp-group"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.instance_group.id

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_image_id
        size     = 20
        type     = "network-hdd"
      }
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }

    metadata = {
      ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
      user-data = templatefile("${path.module}/files/user-data.yaml", {
        image_url = "https://storage.yandexcloud.net/${yandex_storage_bucket.homework.bucket}/${yandex_storage_object.image.key}"
      })
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_creating  = 3
    max_deleting  = 3
    max_expansion = 1
    max_unavailable = 1
  }

  health_check {
    interval = 10
    timeout  = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3

    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name = "lamp-target-group"
  }
}
