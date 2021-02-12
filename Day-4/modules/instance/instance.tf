resource "google_compute_instance" "default" {
  name         = var.name
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
  metadata_startup_script = file("./modules/instance/startup.sh")
  network_interface {
    subnetwork = var.var_public_subnet_name


  }
}
