resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  ip_cidr_range = var.var_public_subnet
  network       = var.network_self_link
  region        = var.region
  #  zone          = var.zone
}
