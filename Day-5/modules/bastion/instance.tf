resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  project      = var.project
  #zone         =   "${element(var.var_zones, count.index)}"
  zone = var.zone
  tags = ["ssh", "vpn"]

  boot_disk {
    initialize_params {
      #image = "centos-7-v20180129"
      image = var.image
    }
  }

  metadata_startup_script = file(var.var_script)
  network_interface {
    subnetwork = var.var_public_subnet_name
    access_config {}

  }
  /*
  provisioner "local-exec" {

    command = "cat /root/lab-client1.ovpn"
    connection {
      host        = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
      type        = "ssh"
      user        = "ubuntu_rhpc"
      private_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCytwpu5vms+miUdKWy07moaFRS3XqFaF9ywpGZYWu+dnubpZ3F5ELTjvAJJKAFAWA+na4eqIIJ9gisw4DEP3rWYrQkY4hBj6djVp5KRsNmLNltweto2KyvzHtVNbdARAfoKIRvtrfsgfLbLWox1ZrkMcgqjjpoqtcmbrLEy7izcW/3px64x+Oe6U4tsxACgRHQYgMJNXWxGCeh581yhjeUk58SWzIn/0Upcxy6pTkn9mdKXZ5xF9dMmOk02kR4zU26I5F4BVIImkBlcBTQR487AeGsz5es5XbxODcUWI6g9VpkzQObeQGHUOmVKwleMh01YiIr1KCYnbRkZtpY2njbQibs8lQGDGQ/2dhFFCZe6Mt8NimvY8md4Tr1lFdC0HCDI3FIgyB0GGN73VukCTET4rOL71cC/Eloxp4sZUKHunXVcrYjqQOOrNy9MyOlmaZxsdLvRfvwclQXSQcFdPvw6Q2tnhJMyPy0nfdxS2rndap7hwFJMKGdD51iNa5LGWU= ubuntu_rhpc"
    }

  }
*/
}
