resource "google_compute_forwarding_rule" "default" {
  name                  = "tomcat-forwarding-rule"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL"
  network               = "skosolapov-vpc"
  subnetwork            = var.var_private_subnet_name
  project               = var.project
  backend_service       = google_compute_region_backend_service.default.self_link
  ip_address            = "10.13.2.100"
  #  ip_protocol           = TCP
  ports = ["8080"]
}

resource "google_compute_region_backend_service" "default" {
  project     = var.project
  name        = "tomcat-backend"
  region      = "us-central1"
  protocol    = "TCP"
  timeout_sec = 10
  backend {
    group = google_compute_region_instance_group_manager.tomcat-manager.instance_group
    #balancing_mode = "UTILIZATION"
    #  capacity_scaler = 1.0
  }
  health_checks = [google_compute_health_check.tcp.id]
}

resource "google_compute_health_check" "tcp" {

  project            = var.project
  name               = "check-website-backend"
  check_interval_sec = 20
  timeout_sec        = 15
  tcp_health_check {
    port = "8080"
  }
}


resource "google_compute_health_check" "http" {
  project            = var.project
  name               = "check-website-backend-http"
  check_interval_sec = 20
  timeout_sec        = 15
  http_health_check {
    port = "8080"
  }
}

resource "google_compute_region_instance_group_manager" "tomcat-manager" {
  name = "tomcat-manager"

  base_instance_name        = "instance-tomcat"
  region                    = "us-central1"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  version {
    instance_template = google_compute_instance_template.instance_tomcat.id
  }
  target_size = 3

  named_port {
    name = "custom"
    port = 8080
  }
}

resource "google_compute_region_health_check" "tomcat-healthcheck" {
  name               = "tomcat-healthcheck"
  timeout_sec        = 1
  check_interval_sec = 1
  http_health_check {
    port = 8080
  }
}


############iam_instance


resource "google_compute_instance_template" "instance_tomcat" {
  name_prefix  = "tomcat-"
  project      = var.project
  machine_type = var.machine_type
  region       = "us-central1"

  // boot disk
  disk {

    source_image = "centos-cloud/centos-7"

  }

  // networking
  network_interface {
    subnetwork = var.var_private_subnet_name
  }
  metadata_startup_script = file("./modules/backend/startup.sh")
  provisioner "file" {
    source      = "./cluster.war"
    destination = "/usr/local/tomcat/webapps/cluster.war"
  }
  lifecycle {
    create_before_destroy = true
  }
}
