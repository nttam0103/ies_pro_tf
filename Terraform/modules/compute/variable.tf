variable "instance_type" {
  type = string
  default = "t2.micro"
  nullable = false
}
variable "ami" {
  type = string 
  nullable = false
}
variable "keypair" {
  type = string 
  nullable = false
}
variable "subnet_id" {
  type = string 
  nullable = false
}
variable "security_groups_ids" {
    type = string 
    nullable = false
}
