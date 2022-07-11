//Main module

module "gce_vpc" {
  source          = "./modules/google_compute_network"
  region          = var.region
  project_id      = var.project_id
  router_gw_name  = "rod-gw"
  router_nat_name = "rod-nat"
  vpc_name_adv    = "advanced-vpc"
  auto_mode       = false
  nat_enabled     = false

  subnet_config = {
    subnet1 = {
      name       = "subnet-1"
      cidr_range = "192.168.43.0/24"
    },
    subnet2 = {
      name       = "subnet-2"
      cidr_range = "192.168.44.0/24"
    }
  }
  subnet_config_adv = {
    subnet1 = {
      name       = "subnet-1-adv"
      cidr_range = "172.12.0.0/24"
    },
    subnet2 = {
      name       = "subnet-2-adv"
      cidr_range = "192.138.0.0/24"
    }
  }
}


module "gce_instance" {
  source     = "./modules/google_compute_instance"
  region     = var.region
  vm_station = [
    {
      prefix        : "dev",
      machine_type  : "f1-micro",
      instance_zone : var.zone,
      network       : module.gce_vpc.vpc_name_advanced,
      subnetwork    : module.gce_vpc.subnet_name_advanced[0],
      tags          : ["web", "re"],
      items         : 3
    }
  ]

  image = "debian-cloud/debian-9"

}

module "gce_firewall" {
  source     = "./modules/google_compute_firewall"
  project_id = var.project_id
  //network    = module.gce_vpc.vpc_name
  fw_rules = [
    { protocol : "tcp",
      name : "rule1",
      ports : [80, 443],
      source_ips : ["193.20.0.4/32", "176.12.34.5/32"],
      destination_tags : ["web", "digma"],
      network = module.gce_vpc.vpc_name
    },

    { protocol : "tcp",
      name : "rule-1c",
      ports : [1495],
      source_ips : ["193.20.0.4/32", "176.12.34.5/32"],
      destination_tags : ["web"],
      network = module.gce_vpc.vpc_name_advanced
    }

  ]
}
