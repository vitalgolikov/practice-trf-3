// google_compute_vpc_advanced
resource "google_compute_network" "advanced_network" {
  project                 = var.project_id
  name                    = var.vpc_name_adv
  auto_create_subnetworks = var.auto_mode
}


// google_compute_subnetworks main
resource "google_compute_subnetwork" "default" {
  for_each      = var.subnet_config
  name          = each.value.name
  ip_cidr_range = each.value.cidr_range
  region        = var.region
  network       = data.google_compute_network.default.id
}

// google_compute_subnetworks advanced
resource "google_compute_subnetwork" "advanced" {
  depends_on = [google_compute_network.advanced_network]
  for_each      = var.subnet_config_adv
  name          = each.value.name
  ip_cidr_range = each.value.cidr_range
  region        = var.region
  network       = var.vpc_name_adv
}



// google_compute_network_peering
resource "google_compute_router" "router_gw_for_vital_vpc" {
  name    = var.router_gw_name
  network = data.google_compute_network.default.id
  region  = var.region
}

// google_compute_router_nat
resource "google_compute_router_nat" "router_nat_for_vital_vpc" {
  count                              = var.nat_enabled ? 1 : 0
  name                               = var.router_nat_name
  router                             = google_compute_router.router_gw_for_vital_vpc.name
  region                             = google_compute_router.router_gw_for_vital_vpc.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}