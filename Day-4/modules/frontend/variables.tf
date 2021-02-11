variable "network_self_link" {
  type        = string
  description = "network_self_link"
  default     = "skosolapov-vpc"
}

variable "var_env" {
  default = "dev"
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
variable "var_private_subnet" {
  type        = string
  description = "private_subnet"
}
variable "var_public_subnet" {
  type        = string
  description = "public_subnet"
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
