# output "network" {
#   value       = module.vpc
#   description = "The created network"
# }

# output "subnets" {
#   value       = module.subnets.subnets
#   description = "A map with keys of form subnet_region/subnet_name and values being the outputs of the google_compute_subnetwork resources used to create corresponding subnets."
# }

# output "network_name" {
#   value       = module.vpc.network_name
#   description = "The name of the VPC being created"
# }

# output "network_id" {
#   value       = module.vpc.network_id
#   description = "The ID of the VPC being created"
# }

# output "network_self_link" {
#   value       = module.vpc.network_self_link
#   description = "The URI of the VPC being created"
# }

# # output "project_id" {
# #   value       = module.vpc.project_id
# #   description = "VPC project id"
# # }

# output "subnets_names" {
#   value       = module.subnets.subnets.name
#   description = "The names of the subnets being created"
# }

# output "subnets_ids" {
#   value       = module.subnets.subnets.network
#   description = "The IDs of the subnets being created"
# }

# output "subnets_ips" {
#   value       = module.subnets.subnets.ip_cidr_range
#   description = "The IPs and CIDRs of the subnets being created"
# }

# # output "subnets_self_links" {
# #   value       = module.subnets.subnets.subnets_self_links
# #   description = "The self-links of subnets being created"
# # }

# output "subnets_regions" {
#   value       = module.subnets.subnets.region
#   description = "The region where the subnets will be created"
# }

# # output "subnets_private_access" {
# #   value       = [for network in module.subnets.subnets : network.private_ip_google_access]
# #   description = "Whether the subnets will have access to Google API's without a public IP"
# # }

# # output "subnets_flow_logs" {
# #   value       = [for network in module.subnets.subnets : length(network.log_config) != 0 ? true : false]
# #   description = "Whether the subnets will have VPC flow logs enabled"
# # }

# output "subnets_secondary_ranges" {
#   value       = module.subnets.subnets.secondary_ip_range.0.range_name
#   description = "The secondary ranges associated with these subnets"
# }

# # output "route_names" {
# #   value       = [for route in module.routes.routes : route.name]
# #   description = "The route names associated with this VPC"
# # }

# //------------------------------------------------------------------------------------
# output "kubernetes_endpoint" {
#   sensitive = true
#   value     = module.gke.endpoint
# }

# output "client_token" {
#   sensitive = true
#   value     = base64encode(data.google_client_config.default.access_token)
# }

# output "ca_certificate" {
#   value = module.gke.ca_certificate
# }

# output "service_account" {
#   description = "The default service account used for running nodes."
#   value       = module.gke.service_account
# }

/******************************************
	PostgreSQL outputs
 *****************************************/

# output "project_id" {
#   value = var.project_id
# }

# output "name" {
#   description = "The name for Cloud SQL instance"
#   value       = module.pg.instance_name
# }

# output "authorized_network" {
#   value = var.pg_ha_external_ip_range
# }

# output "replicas" {
#   value = module.pg.replicas
# }

# output "instances" {
#   value = module.pg.instances
# }

output "service_range" {
  value = module.vpc.vpc_database_service_range
}

output "vpc" {
  value = module.vpc.network_name
}