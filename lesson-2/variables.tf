variable "zone" {
  type        = string
  description = "zone"
}
variable "name" {
  type        = string
  description = "name"
}
variable "machine_type" {
  type        = string
  description = "machine_type"
}
variable "image" {
  type        = string
  description = "image"
}
variable "region" {
  type        = string
  description = "Region"
}
variable "project" {
  type        = string
  description = "project"
}
variable "size" {
  type        = string
  description = "size"
}
variable "type" {
  type        = string
  description = "type"
}
variable "labels" {
  type = map(string)
}
