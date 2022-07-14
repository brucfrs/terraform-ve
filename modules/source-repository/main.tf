resource "google_sourcerepo_repository" "my-repo" {
  name = var.name
  project = var.project
}