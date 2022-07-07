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
  private_ip_range_name_postegre         = var.private_ip_range_name_postegre

  depends_on = [
    google_project_service.api_compute,
    google_project_service.api_resourcemanager
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
# 	Routes
#  *****************************************/
# module "routes" {
#   source            = "./modules/routes"
#   project_id        = var.project_id
#   network_name      = module.vpc.network_name
#   routes            = var.routes
#   module_depends_on = [module.subnets.subnets]
# }

# /******************************************
# 	Firewall rules
#  *****************************************/
# locals {
#   rules = [
#     for f in var.firewall_rules : {
#       name                    = f.name
#       direction               = f.direction
#       priority                = lookup(f, "priority", null)
#       description             = lookup(f, "description", null)
#       ranges                  = lookup(f, "ranges", null)
#       source_tags             = lookup(f, "source_tags", null)
#       source_service_accounts = lookup(f, "source_service_accounts", null)
#       target_tags             = lookup(f, "target_tags", null)
#       target_service_accounts = lookup(f, "target_service_accounts", null)
#       allow                   = lookup(f, "allow", [])
#       deny                    = lookup(f, "deny", [])
#       log_config              = lookup(f, "log_config", null)
#     }
#   ]
# }

# module "firewall_rules" {
#   source       = "./modules/firewall-rules"
#   project_id   = var.project_id
#   network_name = module.vpc.network_name
#   rules        = local.rules
# }

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
  source     = "./modules/gke"
  project_id = lookup(var.project_id, local.env)
  #network_project_id          = lookup(var.project_id, local.env)
  name                            = "cluster-gke-${local.env}"
  regional                        = lookup(var.gke_location, local.env)
  region                          = var.region
  network_name                    = lookup(var.network_name, local.env)
  subnet_name                     = lookup(var.subnet_name, local.env)
  ip_range_pods                   = lookup(var.secundary_range_name_k8s, local.env)
  ip_range_services               = lookup(var.secundary_range_name_services, local.env)
  create_service_account          = false
  service_account                 = var.compute_engine_service_account
  secundary_ip_cidr_range_k8s     = lookup(var.secundary_ip_cidr_range_k8s, local.env)
  default_max_pods_per_node       = var.default_max_pods_per_node
  remove_default_node_pool        = true
  enable_vertical_pod_autoscaling = false
  http_load_balancing             = false
  horizontal_pod_autoscaling      = false

  node_pools = [
    {
      name              = "pool-${local.env}"
      min_count         = 1
      max_count         = 10
      local_ssd_count   = 0
      disk_size_gb      = 50
      disk_type         = "pd-balanced"
      auto_repair       = true
      auto_upgrade      = true
      service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 24
    },
  ]

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

/******************************************
	Database PostgreSQL
 *****************************************/


locals {
  read_replica_ip_configuration = {
    ipv4_enabled       = false
    require_ssl        = false
    private_network    = "projects/${lookup(var.project_id, local.env)}/global/networks/${lookup(var.network_name, local.env)}"
    allocated_ip_range = null
    authorized_networks = [
      {
        name  = lookup(var.subnet_name_postgre, local.env)
        value = lookup(var.subnet_ip_postgre, local.env)
      },
    ]
  }
}

module "postgresql" {
  source               = "./modules/postgresql"
  name                 = "postgre-${local.env}-2"
  random_instance_name = true
  project_id           = lookup(var.project_id, local.env)
  database_version     = "POSTGRES_9_6"
  region               = "us-east1"

  // Master configurations
  tier                            = "db-f1-micro"
  zone                            = "us-east1-b"
  availability_type               = "ZONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  deletion_protection = true

  database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    managed = "terraform"
  }

  ip_configuration = {
    ipv4_enabled       = false
    require_ssl        = false
    private_network    = "projects/${lookup(var.project_id, local.env)}/global/networks/${lookup(var.network_name, local.env)}" #lookup(var.network_name, local.env)
    allocated_ip_range = null
    authorized_networks = [] #acesso a ip publico
  }

  backup_configuration = {
    enabled                        = true
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = null
    retained_backups               = 365
    retention_unit                 = "COUNT"
  }

  // Read replica configurations
  # read_replica_name_suffix = "-test"
  # read_replicas = [
  #   {
  #     name                  = "0"
  #     zone                  = "us-east1-b"
  #     tier                  = "db-custom-1-3840"
  #     ip_configuration      = local.read_replica_ip_configuration
  #     database_flags        = [{ name = "autovacuum", value = "off" }]
  #     disk_autoresize       = var.disk_autoresize
  #     disk_autoresize_limit = var.disk_autoresize_limit
  #     disk_size             = var.disk_size
  #     disk_type             = var.disk_type
  #     user_labels           = { managed = "terraform" }
  #     encryption_key_name   = null
  #   },
  #   # {
  #   #   name                  = "1"
  #   #   zone                  = "us-central1-b"
  #   #   tier                  = "db-custom-1-3840"
  #   #   ip_configuration      = local.read_replica_ip_configuration
  #   #   database_flags        = [{ name = "autovacuum", value = "off" }]
  #   #   disk_autoresize       = null
  #   #   disk_autoresize_limit = null
  #   #   disk_size             = null
  #   #   disk_type             = "PD_HDD"
  #   #   user_labels           = { bar = "baz" }
  #   #   encryption_key_name   = null
  #   # },
  #   # {
  #   #   name                  = "2"
  #   #   zone                  = "us-central1-c"
  #   #   tier                  = "db-custom-1-3840"
  #   #   ip_configuration      = local.read_replica_ip_configuration
  #   #   database_flags        = [{ name = "autovacuum", value = "off" }]
  #   #   disk_autoresize       = null
  #   #   disk_autoresize_limit = null
  #   #   disk_size             = null
  #   #   disk_type             = "PD_HDD"
  #   #   user_labels           = { bar = "baz" }
  #   #   encryption_key_name   = null
  #   # },
  # ]

  # db_name      = lookup(var.database_name, local.env)
  # db_charset   = "UTF8"
  # db_collation = "en_US.UTF8"

  # additional_databases = [
  #   {
  #     name      = "Database additional"
  #     charset   = "UTF8"
  #     collation = "en_US.UTF8"
  #   },
  # ]

  # user_name     = "tftest"
  # user_password = "foobar"

  # additional_users = [
  #   {
  #     name     = "tftest2"
  #     password = "abcdefg"
  #     host     = "localhost"
  #   },
  #   {
  #     name     = "tftest3"
  #     password = "abcdefg"
  #     host     = "localhost"
  #   },
  # ]
    depends_on = [
    module.vpc,
    module.subnets
  ]
}
