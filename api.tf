resource "google_project_service" "api_compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "api_resourcemanager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "api_container" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}
