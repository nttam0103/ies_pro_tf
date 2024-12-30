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
  type = string
}
variable "availability_zones_b" {
  type = string
}
