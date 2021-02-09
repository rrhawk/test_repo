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
  deletion_protection     = true
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }


  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
  lifecycle {
    ignore_changes = ["attached_disk"]
  }
}
output "URL" {
  value = "http://${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}/"
}
resource "google_compute_disk" "disk-2" {
  name                      = "disk-2"
  type                      = var.type
  zone                      = var.zone
  physical_block_size_bytes = 4096
}
resource "google_compute_attached_disk" "disk" {
  disk     = google_compute_disk.disk-2.id
  instance = google_compute_instance.vm_instance.id
}
