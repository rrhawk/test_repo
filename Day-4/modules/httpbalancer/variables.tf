/*variable "vms" {
  description = "vms"
  type        = map(string)
  default = {
    tomcat1 = "a"
    tomcat2 = "b"
    tomcat3 = "c"
  }
}
*/
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
