provider "google" {
  credentials = file("/home/user/terraform-vpn-admin.json")
  project     = var.project
  region      = var.region
}




module "bastion" {
  depends_on = [
    module.vpc,
  ]
  name                   = var.name_b
  source                 = "./modules/bastion"
  machine_type           = var.machine_type
  project                = var.project
  zone                   = var.zone_b
  var_script             = var.script_ssh
  var_public_subnet_name = module.vpc.sub_public_name

}

module "vpc" {
  source = "./modules/global"
  #env                    = var.var_env
  #  company                = var.var_company
  var_vpc_name       = var.vpc_name
  project            = var.project
  var_public_subnet  = var.public_subnet
  var_private_subnet = var.private_subnet
  region             = var.region
  routing_mode       = var.routing_mode
}

output "SSH" {
  value = "Bastion = ssh ubuntu_rhpc@${module.bastion.nat_ip}"
}


resource "google_compute_project_metadata" "my_ssh_key" {
  metadata = {
    ssh-keys = <<EOF
      ubuntu_rhpc:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCytwpu5vms+miUdKWy07moaFRS3XqFaF9ywpGZYWu+dnubpZ3F5ELTjvAJJKAFAWA+na4eqIIJ9gisw4DEP3rWYrQkY4hBj6djVp5KRsNmLNltweto2KyvzHtVNbdARAfoKIRvtrfsgfLbLWox1ZrkMcgqjjpoqtcmbrLEy7izcW/3px64x+Oe6U4tsxACgRHQYgMJNXWxGCeh581yhjeUk58SWzIn/0Upcxy6pTkn9mdKXZ5xF9dMmOk02kR4zU26I5F4BVIImkBlcBTQR487AeGsz5es5XbxODcUWI6g9VpkzQObeQGHUOmVKwleMh01YiIr1KCYnbRkZtpY2njbQibs8lQGDGQ/2dhFFCZe6Mt8NimvY8md4Tr1lFdC0HCDI3FIgyB0GGN73VukCTET4rOL71cC/Eloxp4sZUKHunXVcrYjqQOOrNy9MyOlmaZxsdLvRfvwclQXSQcFdPvw6Q2tnhJMyPy0nfdxS2rndap7hwFJMKGdD51iNa5LGWU= ubuntu_rhpc
      aliaksandr_mazurenka:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgPL4xcYRKgQFz9W8xQ9mnWc9WMZxu2skx121st/f7w7QsEn4L++TCt77vsJ1nqRtfxF/MmXeC326QPulYW7YnOXTcGtmfuZQDVP72EBifglXBIz/CL0ChNfOLK7D5yH9SVpBJfKMU0XsWU+ObzEEpsPXbtC0kZahLRIroBuQjsV5gsaIVDiqIa2ztK1fDSKFXT9AfX1gnlll2Pp0JmVJbqi8gWnouS9Am10hZXm2HpCESBB4dZ9s2ZkYgWKZrXrIFO33ES/2IrLr2MdAsGjMBTlS57c5VSSqCP6PRZ7n08WM3wt41WmT+1EFof+XXgtWvCP95bY9gO2PGpoby15L aliaksandr_mazurenka
    EOF
  }
  project = var.project
}
