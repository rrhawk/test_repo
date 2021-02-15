resource "google_compute_subnetwork" "public" {
  name          = "public-vpn"
  ip_cidr_range = var.var_public_subnet
  network       = google_compute_network.vpc.name
  region        = var.region
  #  zone          = var.zone
}
resource "google_compute_subnetwork" "private" {
  name          = "private-vpn"
  ip_cidr_range = var.var_private_subnet
  network       = google_compute_network.vpc.name
  region        = var.region
  #  zone          = var.zone
}


resource "google_compute_network" "vpc" {
  name = var.var_vpc_name

  auto_create_subnetworks = "false"
  routing_mode            = var.routing_mode
  project                 = var.project

}
resource "google_compute_firewall" "allow-internal" {

  name    = "fw-allow-internal"
  network = google_compute_network.vpc.name
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
    var.var_private_subnet,
    var.var_public_subnet,
  ]
}
resource "google_compute_firewall" "allow-http" {
  name    = "fw-allow-http"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http"]
}
resource "google_compute_firewall" "allow-bastion" {
  name    = "fw-allow-bastion"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}
resource "google_compute_firewall" "allow-vpn" {
  name    = "fw-allow-vpn"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["1194"]
  }

  target_tags = ["vpn"]
}

resource "google_compute_firewall" "firewall_internal_healthcheck" {
  name          = "fw-internal-hc"
  network       = google_compute_network.vpc.name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["lb"]
  direction     = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}


resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.private.region
  network = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
