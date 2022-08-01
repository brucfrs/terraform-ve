output "created_api_host" {
  value = google_endpoints_service.openapi_service.service_name
}