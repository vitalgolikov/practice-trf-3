locals {
  rules = {
    for x in var.fw_rules :
    "${x.name}" => x
  }
}

resource "google_compute_firewall" "rules" {
  for_each = local.rules
  name    =  "firewall-rule-${var.project_id}-${each.value.name }"
  network = each.value.network
  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
      }

  source_ranges = each.value.source_ips
  target_tags   = each.value.destination_tags
  description = "Creates firewall rule with loop"
}




