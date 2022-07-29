# output "subnets" {
#   value       = google_compute_subnetwork.subnetwork
#   description = "The created subnet resources"
# }

output "subnet_self_link" {
  value       = google_compute_subnetwork.subnetwork.self_link
  description = "The created subnet resources"
}