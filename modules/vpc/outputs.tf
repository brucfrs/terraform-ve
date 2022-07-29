# output "network" {
#   value       = google_compute_network.network
#   description = "The VPC resource being created"
# }

# output "network_name" {
#   value       = google_compute_network.network.name
#   description = "The name of the VPC being created"
# }

# output "network_id" {
#   value       = google_compute_network.network.id
#   description = "The ID of the VPC being created"
# }

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}

output "vpc_database_service_range" {
  value =  "${google_compute_global_address.private_ip_address_postegre.address}/29" #google_compute_global_address.private_ip_address_postegre.name
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
 }
