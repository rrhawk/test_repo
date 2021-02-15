provider "google" {
  credentials = file("/home/user/terraform-admin.json")
  project     = var.project
  region      = var.region
}
terraform {
  backend "gcs" {
    bucket = "skosolapov-bucket"
    prefix = "terraform/state"
  }
}


module "vpc" {
  source                  = "./modules/global"
  var_public_subnet_name  = var.public_subnet_name
  var_private_subnet_name = var.private_subnet_name
  var_vpc_name            = var.vpc_name
  project                 = var.project
  var_public_subnet       = var.public_subnet
  var_private_subnet      = var.private_subnet
  region                  = var.region
  routing_mode            = var.routing_mode
}
module "instance" {
  depends_on = [
    module.vpc,
  ]
  source       = "./modules/instance"
  name         = var.name_f
  machine_type = var.machine_type
  project      = var.project
  zone         = var.zone_f
  var_script   = var.script_f
  image        = var.image
  #  var_use_ext_ip = false
  var_tags = ["http"]
}


module "http_balancer" {
  depends_on = [
    module.vpc,
    module.instance,
  ]
  value_frontend       = module.instance.instance_id
  source               = "./modules/httpbalancer"
  zone                 = var.zone_f
  instance-group-name  = var.instance-group-name
  backend-service-name = var.backend-service-name
}
module "backend" {
  depends_on = [
    module.vpc,
  ]
  source                  = "./modules/backend"
  var_script              = var.script_b
  network                 = module.vpc.vpc_name
  var_private_subnet_name = module.vpc.sub_private_name
  machine_type            = var.machine_type
  project                 = var.project
  region                  = var.region
  var_prefix              = var.prefix
  balancer_ip             = var.balancer_ip
  balancer_port           = var.balancer_port
  load_balancing_scheme   = var.load_balancing_scheme
  name                    = var.name_back_forward
  image                   = var.image
  name-instance-gm        = var.name-instance-gm
  #######var_private_subnet_name = "var.var_private_subnet_name"
}
module "bastion" {
  depends_on = [
    module.vpc,
  ]
  name         = var.name_b
  source       = "./modules/bastion"
  machine_type = var.machine_type
  project      = var.project
  zone         = var.zone_b
  var_script   = var.script_ssh
  #  var_use_ext_ip = true
  var_tags = ["vpn", "ssh"]
}




/*output "URL" {
  value = "http://${module.http_balancer.global_ip}/clusterjsp"
}
output "SSH" {
  value = "Bastion = ssh aliaksandr_mazurenka@${module.bastion.nat_ip}"
}
*/
resource "google_compute_project_metadata" "my_ssh_key" {
  metadata = {
    ssh-keys = <<EOF
      aliaksandr_mazurenka:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgPL4xcYRKgQFz9W8xQ9mnWc9WMZxu2skx121st/f7w7QsEn4L++TCt77vsJ1nqRtfxF/MmXeC326QPulYW7YnOXTcGtmfuZQDVP72EBifglXBIz/CL0ChNfOLK7D5yH9SVpBJfKMU0XsWU+ObzEEpsPXbtC0kZahLRIroBuQjsV5gsaIVDiqIa2ztK1fDSKFXT9AfX1gnlll2Pp0JmVJbqi8gWnouS9Am10hZXm2HpCESBB4dZ9s2ZkYgWKZrXrIFO33ES/2IrLr2MdAsGjMBTlS57c5VSSqCP6PRZ7n08WM3wt41WmT+1EFof+XXgtWvCP95bY9gO2PGpoby15L aliaksandr_mazurenka
    EOF
  }
  project = var.project
}
