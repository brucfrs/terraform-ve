resource "google_endpoints_service" "openapi_service" {
  service_name   = var.service_name
  project        = var.project_id
  openapi_config = file(var.api_file_path)
}