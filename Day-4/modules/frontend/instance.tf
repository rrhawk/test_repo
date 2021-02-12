resource "google_compute_global_address" "default" {
  name = "global-appserver-ip"

}

############
resource "google_compute_global_forwarding_rule" "web" {
  name       = "global-appserver-ip80"
  ip_address = google_compute_global_address.default.address
  port_range = "80"
  target     = google_compute_target_http_proxy.default.self_link
}



###############
resource "google_compute_target_http_proxy" "default" {
  name    = "test-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.staging_service.self_link

}
##34.102.147.204
resource "google_compute_instance_group" "staging_group" {
  name = "staging-instance-group"
  zone = "us-central1-c"
  instances = [
    var.value_frontend,
  ]
  named_port {
    name = "http"
    port = "80"
  }


  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_backend_service" "staging_service" {
  name      = "staging-service"
  port_name = "http"
  protocol  = "HTTP"

  backend {
    group = google_compute_instance_group.staging_group.id
  }

  health_checks = [
    google_compute_http_health_check.staging_health.id,
  ]
}

resource "google_compute_http_health_check" "staging_health" {
  name         = "staging-health"
  request_path = "/"
}

#########
