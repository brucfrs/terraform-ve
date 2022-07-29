/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source                                 = "./modules/vpc"
  network_name                           = lookup(var.network_name, local.env)
  auto_create_subnetworks                = var.auto_create_subnetworks
  routing_mode                           = var.routing_mode
  project_id                             = lookup(var.project_id, local.env)
  description                            = var.description
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  mtu                                    = var.mtu
  private_ip_range_name_postegre         = lookup(var.private_ip_range_name_postegre, local.env)

  depends_on = [
    google_project_service.api_compute,
    google_project_service.api_resourcemanager,
    google_project_service.api_network
  ]
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source                           = "./modules/subnets"
  project_id                       = lookup(var.project_id, local.env)
  network_name                     = lookup(var.network_name, local.env)
  subnet_name                      = lookup(var.subnet_name, local.env)
  subnet_ip                        = lookup(var.subnet_ip, local.env)
  secundary_range_name_k8s         = lookup(var.secundary_range_name_k8s, local.env)
  secundary_ip_cidr_range_k8s      = lookup(var.secundary_ip_cidr_range_k8s, local.env)
  secundary_range_name_services    = lookup(var.secundary_range_name_services, local.env)
  secundary_ip_cidr_range_services = lookup(var.secundary_ip_cidr_range_services, local.env)
  subnet_region                    = var.subnet_region

  depends_on = [
    module.vpc
  ]
}


# /******************************************
# 	Cluster GKE
#  *****************************************/

locals {
  cluster_type = "simple-zonal-private"
}

data "google_client_config" "default" {}

data "google_compute_subnetwork" "subnetwork" {
  name    = lookup(var.subnet_name, local.env)
  project = lookup(var.project_id, local.env)
  region  = var.region
}

module "gke" {
  source             = "./modules/gke"
  project_id         = lookup(var.project_id, local.env)
  network_project_id = lookup(var.project_id, local.env)
  name               = lookup(var.cluster_name, local.env)
  regional           = lookup(var.gke_location, local.env)
  region             = var.region
  network_name       = lookup(var.network_name, local.env)
  subnet_name        = lookup(var.subnet_name, local.env)
  subnet_self_link   = module.subnets.subnet_self_link
  ip_range_pods      = lookup(var.secundary_range_name_k8s, local.env)
  ip_range_services  = lookup(var.secundary_range_name_services, local.env)
  # create_service_account          = var.create_service_account
  secundary_ip_cidr_range_k8s     = lookup(var.secundary_ip_cidr_range_k8s, local.env)
  default_max_pods_per_node       = var.default_max_pods_per_node
  remove_default_node_pool        = true
  enable_vertical_pod_autoscaling = var.enable_vertical_pod_autoscaling
  http_load_balancing             = var.http_load_balancing
  horizontal_pod_autoscaling      = var.horizontal_pod_autoscaling

  node_pools = lookup(var.node_pools, local.env)
  #apagar se estiver ok
  # [
  #   {
  #     name              = "pool-${local.env}"
  #     min_count         = 1
  #     max_count         = 10
  #     local_ssd_count   = 0
  #     disk_size_gb      = 50
  #     disk_type         = "pd-balanced"
  #     auto_repair       = true
  #     auto_upgrade      = true
  #     autoscaling       = true
  #     machine_type      = "e2-medium"
  #     preemptible       = false
  #     max_pods_per_node = 24
  #   },
  # ]

  master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "VPC"
    },
  ]
  depends_on = [
    module.vpc,
    module.subnets
  ]
}

# # /******************************************
# # 	Database PostgreSQL
# #  *****************************************/

module "postgresql" {
  source            = "./modules/postgresql"
  name              = lookup(var.postgre_instance_name, local.env)
  project_id        = lookup(var.project_id, local.env)
  database_version  = var.database_version
  region            = var.region
  tier              = var.postgre_machine_type
  zone              = var.postgre_zone
  availability_type = lookup(var.postgre_availability_type, local.env)

  user_labels = {
    managed = "terraform",
    env     = local.env
  }

  ip_configuration = {
    ipv4_enabled        = false
    require_ssl         = false
    private_network     = module.vpc.network_self_link
    allocated_ip_range  = null
    authorized_networks = [] #acesso a ip publico
  }

  # backup_configuration = {
  #   enabled                        = true
  #   start_time                     = "23:00"
  #   location                       = var.region
  #   point_in_time_recovery_enabled = true
  #   transaction_log_retention_days = 7
  #   retained_backups               = 365
  #   retention_unit                 = "COUNT"
  # }

  depends_on = [
    module.vpc,
    module.subnets,
    google_project_service.api_sql
  ]
}

# # /******************************************
# # 	Memorystore Redis
# #  *****************************************/

module "memstore" {
  source = "./modules/memorystore-redis"

  name                    = lookup(var.memorystore_name, local.env)
  project_id              = lookup(var.project_id, local.env)
  region                  = var.region
  location_id             = var.memorystore_location_id
  alternative_location_id = var.memorystore_alternative_location_id
  authorized_network      = module.vpc.network_self_link
  memory_size_gb          = lookup(var.redis_memory_size_gb, local.env)
  replica_count           = lookup(var.redis_replica_number, local.env)
  display_name            = lookup(var.display_name, local.env)
  labels                  = var.memorystore_labels
  reserved_ip_range       = module.vpc.vpc_database_service_range

  depends_on = [
    google_project_service.api_redis
  ]

}


/******************************************
	Artifact Registry 
 *****************************************/

module "artifact-registry" {
  source = "./modules/artifact-registry"

  name        = var.artifact_registry_name
  region      = var.region
  description = var.artifact_registry_description
  labels      = var.artifact_registry_labels

  depends_on = [
    google_project_service.api_artifact
  ]

}


# # # /******************************************
# # # 	Cloud Storage
# # #  *****************************************/

module "cloud-storage" {
  source = "./modules/cloud-storage"

  name          = var.bucket-name
  project_id    = lookup(var.project_id, local.env)
  region        = var.region
  storage_class = var.storage_class
  versioning    = var.versioning
  labels        = var.storage_labels
  # retention_period = var.retention_period
  age    = var.life_cycle_days
  action = var.life_cycle_action



  depends_on = [
    google_project_service.api_repo
  ]

}

# # # /******************************************
# # # 	Cloud Storage
# # #  *****************************************/

module "nat" {
  source      = "./modules/nat"
  router_name = var.router_name
  region      = var.region
  vpc         = module.vpc.network_name
  nat_name    = var.nat_name

  depends_on = [
    module.vpc,
    module.subnets
  ]
}