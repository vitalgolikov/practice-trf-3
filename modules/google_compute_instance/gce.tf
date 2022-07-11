// google_compute_instance

locals {
  vm_conf = {
  //      for x in var.vm_station : [for (i = 0; i < x.items; i++): {" ${i}  ${x.prefix}" => x}]
 for x in var.vm_station :
  "${x.prefix}" => x
  }

}

resource "google_compute_instance" "default" {

  for_each     = local.vm_conf
  name         = "vm-${each.key}"
  machine_type = each.value.machine_type
  zone         = each.value.instance_zone


  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }

  tags = each.value.tags

  dynamic "network_interface" {
    //for_each =  {for cfg in each.value.network_config : "LAN-${cfg.network}"=> cfg}
    for_each = each.value.network_config
    content {
     network    = network_interface.value.network
     subnetwork =  network_interface.value.subnetwork

    }
  }

}






