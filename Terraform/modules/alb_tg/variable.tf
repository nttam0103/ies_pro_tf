
variable "system_code" {
    description = "System Code"
    type = string
    nullable = false
    
}
variable "security_groups" {
  type = string 
  nullable = false
}
variable "public_subnets" {
  type = list(string)
  nullable = false
}
variable "vpc_id" { 
  type = string
  nullable = false
}