/******************************************
	VPC configuration
 *****************************************/
 
resource "google_compute_network" "network" {
  name                            = var.network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  project                         = var.project_id
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_internet_gateway_routes
  mtu                             = var.mtu
}

resource "google_compute_global_address" "private_ip_address_postegre" {
  name          = var.private_ip_range_name_postegre
  purpose       = var.private_ip_range_purpose
  address_type  = var.private_ip_range_address_type
  prefix_length = var.private_ip_range_prefix_length
  network       = google_compute_network.network.self_link
  address       =  var.private_ip_range_address

}

# Establish VPC network peering connection using the reserved address range
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.network.self_link
  service                 = var.private_vpc_connection_service
  reserved_peering_ranges = [google_compute_global_address.private_ip_address_postegre.name]
}