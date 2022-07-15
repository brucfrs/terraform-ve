# resource "google_app_engine_application" "app" {
#   project     = "terraform-dev-354612"
#   location_id = var.region
#   database_type = "CLOUD_FIRESTORE"
# }

# resource "google_project_service" "app" {
#   project = "terraform-dev-354612"
#   service = "appengine.googleapis.com"
#   disable_on_destroy = false
# }