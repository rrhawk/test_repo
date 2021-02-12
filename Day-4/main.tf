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
module "frontend" {
  depends_on = [
    module.vpc,
  ]
  source = "./modules/frontend"
  ########var_public_subnet_name = "var.var_public_subnet_name"
  #network_self_link = module.vpc.vpc.name
  #subnetwork1        = module.frontend.out_public_subnet_name
  #env                    = var.var_env
  #company                = var.var_company
  #var_public_subnet  = var.public_subnet
  #  var_private_subnet = var.private_subnet
}
module "backend" {
  depends_on = [
    module.vpc,
  ]
  source = "./modules/backend"
  #######var_private_subnet_name = "var.var_private_subnet_name"
}
