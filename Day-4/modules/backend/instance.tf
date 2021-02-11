/*resource "google_compute_instance_group" "tomcats" {
  name        = "tomcat-webservers"
  description = "Terraform test instance group"
  project     = var.project

  for_each  = toset(["tomcat1", "tomcat2", "tomcat3"])
  instances = ["google_compute_instance.${each.key}.id", ]

  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "8443"
  }


}
*/


resource "google_compute_forwarding_rule" "default" {
  name                  = "tomcat-forwarding-rule"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_backend_service.backend.id
  all_ports             = true
  allow_global_access   = true
  network               = "kosolapov-vpc"
}
resource "google_compute_backend_service" "backend" {
  name = "tomcat-backend"

  protocol = "TCP"

  health_checks = [google_compute_health_check.hc.id]
}
resource "google_compute_health_check" "hc" {
  name               = "check-website-backend"
  check_interval_sec = 1
  timeout_sec        = 1
  tcp_health_check {
    port = "8080"
  }
}



resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "8080"
  }
}
resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = [
    "us-central1-a/myinstance1",
    "us-central1-b/myinstance2",
    "us-central1-c/myinstance3",

  ]

  health_checks = [
    google_compute_http_health_check.default.name,
  ]
}

resource "google_compute_http_health_check" "default" {
  name               = "default"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-igm"

  base_instance_name        = "app"
  region                    = "us-central1"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  version {
    instance_template = google_compute_instance_template.instance_template.self_link

  }

  target_pools = [google_compute_target_pool.default.id]
  target_size  = 3

  named_port {
    name = "custom"
    port = 8080
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

data "google_compute_region_instance_group" "staging_group" {
  self_link = google_compute_region_instance_group_manager.appserver.instance_group
}






/*
data "google_compute_region_instance_group" "staging_group" {
  name   = "staging-instance-group"
  region = var.region
  instances = [
    google_compute_instance.tomcat1.id,
    google_compute_instance.tomcat2.id,
    google_compute_instance.tomcat3.id,
  ]
  named_port {
    name = "http"
    port = "8080"
  }


  lifecycle {
    create_before_destroy = true
  }
}
*/



resource "google_compute_instance_template" "instance_template" {
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

  lifecycle {
    create_before_destroy = true
  }
}






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
