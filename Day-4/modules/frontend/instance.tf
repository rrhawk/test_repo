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


  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.staging_service.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.staging_service.id
    }
  }

}
##34.102.147.204
resource "google_compute_instance_group" "staging_group" {
  name = "staging-instance-group"
  zone = "us-central1-c"
  instances = [
    google_compute_instance.default.id,
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

resource "google_compute_instance" "default" {
  name         = "frontend"
  machine_type = var.machine_type
  project      = var.project
  #zone         =   "${element(var.var_zones, count.index)}"
  zone = var.zone
  tags = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  /*  labels {
    webserver = "true"
  }*/
  metadata_startup_script = file("startup.sh")
  network_interface {
    subnetwork = var.var_public_subnet_name


  }
}
