variable "fw_rules" {
  type = list(object(
    { protocol         = string,
      name             = string,
      ports            = list(any),
      source_ips       = list(string),
      destination_tags = list(string),
      network          = string

  }))
  description = "flist of firewalls define on network"

}

variable "project_id" {
  type        = string
//  default     = "fresh-span-354807"
  description = "project ID"

}
/*
variable "network" {
  type        = string
  description = "network"
//  default     = "default"
}
*/

//[{"protocol": "tcp", ports: {443,80},  source_ips: ["10.0.0.0/16", "172.10.0.0/24"], destination_tags ["145.34.6.67/32", "123.45.67.8/32"]]