
resource "google_compute_forwarding_rule" "default" {
  name                  = "tomcat-forwarding-rule"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend.id
  all_ports             = true
  #  allow_global_access   = true
  network = "skosolapov-vpc"


  subnetwork = var.var_private_subnet_name
  #target              = google_compute_target_pool.default.id

}
resource "google_compute_region_backend_service" "backend" {
  name     = "tomcat-backend"
  region   = "us-central1"
  protocol = "TCP"

  health_checks = [google_compute_health_check.hc.id]
}
resource "google_compute_health_check" "hc" {
  name               = "check-website-backend"
  check_interval_sec = 20
  timeout_sec        = 15
  tcp_health_check {
    port = "8080"
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 20
  timeout_sec         = 15
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "8080"
  }
}

resource "google_compute_target_pool" "default" {
  name   = "instance-pool"
  region = "us-central1"
  instances = [
    "us-central1-a/tomcat1",
    "us-central1-b/tomcat2",
    "us-central1-c/tomcat3",

  ]

  health_checks = [
    google_compute_http_health_check.default.name,
  ]
}

resource "google_compute_http_health_check" "default" {
  name               = "default"
  request_path       = "/"
  check_interval_sec = 20
  timeout_sec        = 15
  port               = "8080"
}

resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-tomcat"

  base_instance_name        = "instance-tomcat"
  region                    = "us-central1"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  version {
    instance_template = google_compute_instance_template.instance_tomcat.self_link

  }

  #target_pools = [google_compute_target_pool.default.id]
  target_size = 3

  named_port {
    name = "custom"
    port = 8080
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 200
  }
}

data "google_compute_region_instance_group" "staging_group" {
  self_link = google_compute_region_instance_group_manager.appserver.instance_group

}








resource "google_compute_instance_template" "instance_tomcat" {
  name_prefix  = "tomcat-"
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

  lifecycle {
    create_before_destroy = true
  }
}




/*

resource "google_compute_instance" "tomcat1" {
  name         = "tomcat1"
  machine_type = var.machine_type
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  network_interface {
    subnetwork = var.var_private_subnet_name
  }
}
resource "google_compute_instance" "tomcat2" {
  name         = "tomcat2"
  machine_type = var.machine_type
  zone         = "us-central1-b"
  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  network_interface {
    subnetwork = var.var_private_subnet_name
  }
}
resource "google_compute_instance" "tomcat3" {
  name         = "tomcat3"
  machine_type = var.machine_type
  zone         = "us-central1-c"
  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  network_interface {
    subnetwork = var.var_private_subnet_name
  }

}
*/
