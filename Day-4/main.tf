provider "google" {
  credentials = file("/home/user/terraform-admin.json")
  project     = var.project
  region      = var.region
}

module "vpc" {
  source = "./modules/global"
  #env                    = var.var_env
  #  company                = var.var_company
  var_public_subnet  = var.public_subnet
  var_private_subnet = var.private_subnet
}
module "frontend" {
  depends_on = [
    "module.vpc",
  ]
  source = "./modules/frontend"
  #network_self_link = module.vpc.vpc.name
  #subnetwork1        = module.frontend.out_public_subnet_name
  #env                    = var.var_env
  #company                = var.var_company
  var_public_subnet  = var.public_subnet
  var_private_subnet = var.private_subnet
}
