provider "google" {
  credentials = file("/home/user/terraform-admin.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}
resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = var.machine_type
  labels       = var.labels

  tags                    = ["http-server", "https-server"]
  metadata_startup_script = file("startup.sh")
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }


  network_interface {
    subnetwork = google_compute_subnetwork.public.name
    access_config {
    }
  }
}
output "URL" {
  value = "http://${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}/"
}
