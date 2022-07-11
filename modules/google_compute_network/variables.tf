// Gateway router name
variable "router_gw_name" {
  type = string
  description = "Router gateway name"

}

// Nat router name
variable "router_nat_name" {
  type = string
  description = "Router NAT name"

}

// Region
variable "region" {
  type = string
  description = "Region for subnet"

}

// Nat option (disabled or enabled
variable "nat_enabled" {
  type        = bool
  description = "Enabled or disabled NAT"
}


// Main subnets variables
variable "subnet_config" {
  type = map(any)
  description = "Main subnet and CIDR"
}

//Advanced Subnets variables
variable "subnet_config_adv" {
  type = map(any)
  description = "advanced subnet and CIDR"
}

// Project ID
variable "project_id" {
  type = string
  description = "project ID"

}

//VPC advanced name
variable "vpc_name_adv" {
  type = string
  description = "vpc name advanced"
}

//Auto mode creating and assignet networks
variable "auto_mode" {
  type = bool
  description = "Parametr assignet create automatic or manual"
}

/*
variable "network_interfaces" {
  type = map(any)
  description = "vpc and subnet info for array"
}
*/

