output "URL" {
  value = "http://${module.http_balancer.global_ip}/clusterjsp"
}
output "SSH" {
  value = "Bastion, Openvpn = ssh aliaksandr_mazurenka@${module.bastion.nat_ip}"
}
