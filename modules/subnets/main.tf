/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip
  region        = var.subnet_region
  //private_ip_google_access = lookup(each.value, "subnet_private_access", "false")
  #   dynamic "log_config" {
  #     for_each = lookup(each.value, "subnet_flow_logs", false) ? [{
  #       aggregation_interval = lookup(each.value, "subnet_flow_logs_interval", "INTERVAL_5_SEC")
  #       flow_sampling        = lookup(each.value, "subnet_flow_logs_sampling", "0.5")
  #       metadata             = lookup(each.value, "subnet_flow_logs_metadata", "INCLUDE_ALL_METADATA")
  #       filter_expr          = lookup(each.value, "subnet_flow_logs_filter", "true")
  #     }] : []
  #     content {
  #       aggregation_interval = log_config.value.aggregation_interval
  #       flow_sampling        = log_config.value.flow_sampling
  #       metadata             = log_config.value.metadata
  #       filter_expr          = log_config.value.filter_expr
  #     }
  #   }
  network = var.network_name
  project = var.project_id
  //description = lookup(each.value, "description", null)

  secondary_ip_range {
    range_name    = var.secundary_range_name_k8s
    ip_cidr_range = var.secundary_ip_cidr_range_k8s
  }

  secondary_ip_range {
    range_name    = var.secundary_range_name_services
    ip_cidr_range = var.secundary_ip_cidr_range_services
  }

  # secondary_ip_range {
  #   range_name    = var.secundary_range_name_db
  #   ip_cidr_range = var.secundary_ip_cidr_range_db
  # }

  //purpose = lookup(each.value, "purpose", null)
  //role    = lookup(each.value, "role", null)
}