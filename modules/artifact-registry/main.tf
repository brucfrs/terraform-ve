resource "google_artifact_registry_repository" "my-repo" {
  provider = google-beta

  location = var.region
  repository_id = var.name
  description = var.description
  format = var.format #"DOCKER"
  labels = var.labels
}

resource "google_project_service" "project" {
  service = "containerscanning.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy = true
}