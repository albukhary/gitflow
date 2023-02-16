variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "VPC"
}
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}
variable "public_subnet_az" {
  default = "us-east-1a"
}
variable "public_subnet_name" {
  default = "public"
}
variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}
variable "private_subnet_az" {
  default = "us-east-1a"
}
variable "private_subnet_name" {
  default = "private"
}
variable "database_subnet_cidr" {
  default = "10.0.3.0/24"
}
variable "database_subnet_az" {
  default = "us-east-1a"
}
variable "database_subnet_name" {
  default = "database"
}
variable "igw_name" {
  default = "igw"
}
variable "public_route_table_name" {
  default = "public-crt"
}
variable "nat_gateway_name" {
  default = "NatGateway"
}


