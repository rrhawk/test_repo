variable "var_script" {
  default = "./startup_tomcat.sh"
}
variable "machine_type" {
  type        = string
  description = "machine_type"
  default     = "n1-custom-1-4608"
}
variable "image" {
  type        = string
  description = "image"
  default     = "centos-7"
}
variable "var_private_subnet_name" {
  type        = string
  description = "private_subnet"
  default     = "private"
}
variable "region" {
  type        = string
  description = "Region"
  default     = "us-central1"
}
variable "project" {
  type        = string
  description = "project"
  default     = "my-12345-project"
}
variable "load_balancing_scheme" {
  default = "INTERNAL"
}
variable "name" {
  default = "tomcat-forwarding-rule"
}
variable "balancer_ip" {
  default = "10.13.2.100"
}
variable "balancer_port" {
  default = "8080"
}
variable "number_of_instances" {
  default = "3"
}
variable "var_prefix" {
  default = "tomcat-"
}
variable "network" {
  default = "skosolapov-vpc"
}
variable "name-instance-gm" {
  default = "tomcat-manager"
}
