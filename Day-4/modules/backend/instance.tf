resource "google_compute_forwarding_rule" "default" {
  name                  = var.name
  region                = var.region
  load_balancing_scheme = var.load_balancing_scheme
  network               = var.network
  subnetwork            = var.var_private_subnet_name
  project               = var.project
  backend_service       = google_compute_region_backend_service.default.self_link
  ip_address            = var.balancer_ip
  ports                 = [var.balancer_port]
}

resource "google_compute_region_backend_service" "default" {
  project     = var.project
  name        = "tomcat-backend"
  region      = var.region
  protocol    = "TCP"
  timeout_sec = 10
  backend {
    group = google_compute_region_instance_group_manager.tomcat-manager.instance_group

  }
  health_checks = [google_compute_health_check.tcp.id]
}

resource "google_compute_health_check" "tcp" {

  project            = var.project
  name               = "check-website-backend"
  check_interval_sec = 20
  timeout_sec        = 15
  tcp_health_check {
    port = var.balancer_port
  }
}


resource "google_compute_health_check" "http" {
  project            = var.project
  name               = "check-website-backend-http"
  check_interval_sec = 20
  timeout_sec        = 15
  http_health_check {
    port = var.balancer_port
  }
}

resource "google_compute_region_instance_group_manager" "tomcat-manager" {
  name = var.name-instance-gm

  base_instance_name        = "instance-tomcat"
  region                    = var.region
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  version {
    instance_template = google_compute_instance_template.instance_tomcat.id
  }
  target_size = var.number_of_instances
  auto_healing_policies {
    health_check      = google_compute_health_check.tcp.id
    initial_delay_sec = 300
  }
  named_port {
    name = "custom"
    port = var.balancer_port
  }
}


resource "google_compute_instance_template" "instance_tomcat" {
  name_prefix  = var.var_prefix
  project      = var.project
  machine_type = var.machine_type
  region       = var.region
  tags         = ["lb"]
  // boot disk
  disk {

    source_image = var.image

  }

  // networking
  network_interface {
    subnetwork = var.var_private_subnet_name
  }
  metadata_startup_script = file(var.var_script)

  lifecycle {
    create_before_destroy = true
  }
}
