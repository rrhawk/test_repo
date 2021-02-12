resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  project      = var.project
  #zone         =   "${element(var.var_zones, count.index)}"
  zone = var.zone
  tags = ["ssh"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  /*  labels {
    webserver = "true"
  }*/

  network_interface {
    subnetwork = var.var_public_subnet_name


  }
}
