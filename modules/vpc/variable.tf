variable "region" {
  type = string
}
variable "cidr_block" {
  type = string
  nullable = false
}

variable "public_subnet_ies" {
  type = list(string)
  nullable = false
}

variable "private_subnet_ies" {
  type = list(string)
  nullable = false
}

variable "availability_zones_a" {
  description = "values for availability zones"
  type = string
}
variable "availability_zones_b" {
  description = "values for availability zones"
  type = string
}