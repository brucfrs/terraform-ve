/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip
  region        = var.subnet_region
  network = var.network_name
  project = var.project_id

  secondary_ip_range {
    range_name    = var.secundary_range_name_k8s
    ip_cidr_range = var.secundary_ip_cidr_range_k8s
  }

  secondary_ip_range {
    range_name    = var.secundary_range_name_services
    ip_cidr_range = var.secundary_ip_cidr_range_services
  }
}