
variable "var_vpc_name" {
  type        = string
  description = "name"
  default     = "skosolapov-vpc"
}
variable "var_private_subnet" {
  type        = string
  description = "private_subnet"
  default     = "10.13.2.0/24"
}
variable "var_public_subnet" {
  type        = string
  description = "public_subnet"
  default     = "10.13.1.0/24"
}
variable "project" {
  type        = string
  description = "project"
  default     = "my-12345-project"
}
variable "student_name" {
  type    = string
  default = "skosolapov"
}
variable "region" {
  type        = string
  description = "Region"
  default     = "us-central1"
}
variable "routing_mode" {
  default = "INTERNAL"
}
variable "var_public_subnet_name" {
  type        = string
  description = "public_subnet"
  default     = "public"
}
variable "var_private_subnet_name" {
  type        = string
  description = "private_subnet"
  default     = "private"
}
