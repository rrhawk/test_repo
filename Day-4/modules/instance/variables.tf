variable "name" {
  type    = string
  default = "vm"
}
variable "zone" {
  type        = string
  description = "zone"
  default     = "us-central1-c"
}
variable "image" {
  type        = string
  description = "image"
  default     = "centos-7"
}
variable "region" {
  type        = string
  description = "Region"
  default     = "us-central1"
}
variable "machine_type" {
  type        = string
  description = "machine_type"
  default     = "n1-custom-1-4608"
}
variable "project" {
  type        = string
  description = "project"
  default     = "my-12345-project"
}
variable "var_public_subnet_name" {
  default = "public"
}
