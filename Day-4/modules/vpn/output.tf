output "secret" {
  value = google_compute_vpn_tunnel.tunnel1.shared_secret
}
output "vpn_ip" {
  value = google_compute_address.vpn_static_ip.address
}
