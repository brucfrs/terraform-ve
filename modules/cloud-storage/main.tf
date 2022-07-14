resource "google_storage_bucket" "storage" {
  name          = var.name
  project =     var.project_id
  location      = var.region
  force_destroy = var.force_destroy
  storage_class = var.storage_class
  versioning  {
     enabled = var.versioning
    }
  labels        = var.labels
  uniform_bucket_level_access = var.uniform_bucket_level_access
  # retention_policy {
  #   retention_period = var.retention_period
  # }


  lifecycle_rule {
    condition {
      age = var.age
    }
    action {
      type = var.action
    }
  }
}

