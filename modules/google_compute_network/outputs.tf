output "vpc_name" {
  value = data.google_compute_network.default.self_link
}

output "vpc_name_advanced" {
  value = google_compute_network.advanced_network.self_link
}

output "vpc_array" {
  value = [data.google_compute_network.default.self_link, google_compute_network.advanced_network.self_link]
}

output "subnet_name" {
  value = [for k, s in var.subnet_config : s.name]
}

output "subnet_name_advanced" {
  value = [for k, s in var.subnet_config_adv : s.name]
}

output "subnet_ip_cidr_range" {
  value = [for k, i in var.subnet_config : i.cidr_range]
}