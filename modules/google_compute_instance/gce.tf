// google_compute_instance

locals {
  vm_conf = {
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
      image = var.image
    }
  }

  tags = each.value.tags

  dynamic "network_interface" {
    for_each = var.vm_station
    content {
      network    = each.value.network
      subnetwork = each.value.subnetwork

    }
  }

}






