output "URL" {
  value = "http://${module.http_balancer.global_ip}/clusterjsp"
}
output "SSH" {
  value = "Bastion, Openvpn = ssh aliaksandr_mazurenka@${module.bastion.nat_ip}"
}
output "VPN" {
  value = <<EOF
  Need OpenVpn client
  scp aliaksandr_mazurenka@${module.bastion.nat_ip}:/opt/lab-client1.ovpn
  sudo cp lab-client1.ovpn /etc/openvpn/client.conf
  sudo openvpn --client --config /etc/openvpn/client.conf"
  EOF
}
