//Array with variables for creating GKE
variable "vm_station" {
  type = list(object(
    { prefix        = string,
      machine_type  = string,
      instance_zone = string,
      network_config =map(string({
        network       = string,
        subnetwork    = string
      })),
      tags          = list(string),
      image         = string,
      items        = number

  }))
  description = "Description of structure"

}



/*
variable "image" {
  type = string
  //  default = "debian-cloud/debian-9"
  description = "Installed image OS"

}

*/


variable "region" {
  type = string
  //  default = "us-central"
  description = "Region for subnet"
}


