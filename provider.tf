provider "google" {
  credentials = file(var.gcp_credentials[local.env])
  project     = var.project_id[local.env]
  region      = "southamerica-east1"
}
provider "google-beta" {
  credentials = file(var.gcp_credentials[local.env])
  project     = var.project_id[local.env]
  region      = "southamerica-east1"
}