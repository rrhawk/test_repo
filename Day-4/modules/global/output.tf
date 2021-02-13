output "vpc_name" {
  value = google_compute_network.vpc.name
}
output "sub_private_name" {
  value = google_compute_subnetwork.private.name
}
output "sub_public_name" {
  value = google_compute_subnetwork.public.name
}
