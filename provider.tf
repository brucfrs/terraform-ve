provider "google" {
  credentials = file(var.gcp_credentials[local.env])
  project     = var.project_id[local.env]
  region      = "us-east1"
}