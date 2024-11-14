variable "region" {
  type    = string
  default = "us-east-2"
}
variable "cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}

variable "public_subnet_ies" {
  type    = list(string)
  default = ["172.16.1.0/24", "172.16.2.0/24"]
}

variable "private_subnet_ies" {
  type    = list(string)
  default = ["172.16.4.0/24", "172.16.5.0/24"]
}
variable "availability_zones_a" {
  type    = string
  default = "us-east-2a"
}
variable "availability_zones_b" {
  type    = string
  default = "us-east-2b"
}
variable "rds_post" {
  type = string
  default = "3306"
}
