resource "google_redis_instance" "default" {

  project            = var.project_id
  name               = var.name
  tier               = var.tier
  replica_count      = var.tier == "STANDARD_HA" ? var.replica_count : null
  read_replicas_mode = var.tier == "STANDARD_HA" ? var.read_replicas_mode : null
  memory_size_gb     = var.memory_size_gb
  connect_mode       = var.connect_mode

  region                  = var.region
  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id

  authorized_network = var.authorized_network

  redis_version     = var.redis_version
  redis_configs     = var.redis_configs
  display_name      = var.display_name
  reserved_ip_range = var.reserved_ip_range

  labels = var.labels

  auth_enabled = var.auth_enabled

  transit_encryption_mode = var.transit_encryption_mode

   maintenance_policy {
    weekly_maintenance_window {
      day = "SATURDAY"
      start_time {
        hours = 3
        minutes = 0
        seconds = 0
        nanos = 0
      }
    }
  }
}