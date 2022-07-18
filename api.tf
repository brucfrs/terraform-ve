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

resource "google_project_service" "api_redis" {
  service            = "redis.googleapis.com"
  disable_on_destroy = false

}

resource "google_project_service" "api_artifact" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false

}

resource "google_project_service" "api_repo" {
  service            = "sourcerepo.googleapis.com"
  disable_on_destroy = false

}

resource "google_project_service" "api_network" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false

}

resource "google_project_service" "api_sql" {
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false

}
