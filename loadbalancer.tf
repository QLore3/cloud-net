resource "yandex_lb_network_load_balancer" "lamp" {
  name = "lamp-load-balancer"

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp.load_balancer[0].target_group_id

    healthcheck {
      name = "http"

      http_options {
        port = 80
        path = "/"
      }
    }
  }

  listener {
    name        = "http-listener"
    port        = 80
    target_port = 80

    external_address_spec {
      ip_version = "ipv4"
    }
  }
}
