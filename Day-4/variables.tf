variable "private_subnet" {
  type        = string
  description = "private_subnet"
  default     = "10.13.2.0/24"
}
variable "public_subnet" {
  type        = string
  description = "public_subnet"
  default     = "10.13.1.0/24"
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
variable "vpc_name" {
  type    = string
  default = "skosolapov-vpc"
}
variable "routing_mode" {
  default = "GLOBAL"
}



/*variable "var_public_subnet_name" {
  default = google_compute_subnetwork.public_subnet.name
}
variable "var_private_subnet_name" {
  default = google_compute_subnetwork.private_subnet.name
}
*/
