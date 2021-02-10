resource "google_compute_subnetwork" "vpc-with-subnetwork" {
  name          = "vpc-subnetwork"
  description   = "subnettworks for vpc"
  ip_cidr_range = "10.${var.student_idnum}.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
  secondary_ip_range {
    range_name    = "tf-internal-range"
    ip_cidr_range = "10.${var.student_idnum}.2.0/24"
  }
}



resource "google_compute_network" "vpc" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description             = "vpc network"
  routing_mode            = "GLOBAL"
}


resource "google_compute_firewall" "allow-internal" {
  name        = "fw-allow-internal"
  network     = google_compute_network.vpc.name
  description = "firewall for  vpc network - internal connections"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "10.${var.student_idnum}.2.0/24",
  ]
}
resource "google_compute_firewall" "allow-http" {
  name        = "fw-allow-http"
  description = "firewall for  vpc network - external connections"
  network     = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = [var.external_network]
}
resource "google_compute_firewall" "allow-bastion" {
  name        = "fw-allow-bastion"
  description = "firewall for  vpc network - external connections"
  network     = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.external_network]
}
