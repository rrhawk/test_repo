
variable "name" {
  type        = string
  description = "name"
  default     = "vpc"
}
variable "var_private_subnet" {
  type        = string
  description = "private_subnet"
}
variable "var_public_subnet" {
  type        = string
  description = "public_subnet"
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
