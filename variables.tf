variable "project_id" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ID of the project where this VPC will be created"
  default = {
    dev = "vivae-poc"
    hml = "vivae-hml"
    prd = "vivae-poc"
  }
}

variable "gcp_credentials" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The json key name of the google cloud credentials for each project"
  default = {
    dev = "terraform-dev.json"
    hml = "terraform-hml.json"
    prd = "terraform-dev.json"
  }
}

/******************************************
	VPC variables
 *****************************************/
variable "network_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the network being created in each project"
  default = {
    dev = "vpc-dev"
    hml = "vpc-hml"
    prd = "vpc-prd"

  }
}

variable "routing_mode" {
  type        = string
  description = "The network routing mode (default 'REGIONAL')"
  default     = "REGIONAL"
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = "Cluster description"
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  default     = 1460
}

variable "private_ip_range_name_postegre" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the private ip range of the private service network range for postegre."
  default = {
    dev = "postegre-dev-range"
    hml = "postegre-hml-range"
    prd = "postegre-prd-range"

  }
}

/******************************************
	Subnet variables
 *****************************************/

variable "subnet_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the subnetwork that will be created"
  default = {
    dev = "subnet-dev"
    hml = "subnet-hml"
    prd = "subnet-prd"
  }
}

variable "subnet_ip" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ip range of the subnet that will be created"
  default = {
    dev = "10.0.0.0/24"
    hml = "10.1.0.0/24"
    prd = "10.2.0.0/24"
  }
}

variable "secundary_range_name_k8s" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the secondary ip range that will be created for the k8s pods"
  default = {
    dev = "subnet-dev-k8s"
    hml = "subnet-hml-k8s"
    prd = "subnet-prd-k8s"
  }
}

variable "secundary_ip_cidr_range_k8s" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ip range of the secondary ip range that will be created for the k8s pods"
  default = {
    dev = "10.0.1.0/24"
    hml = "10.1.1.0/24"
    prd = "10.2.1.0/24"
  }
}

variable "secundary_range_name_services" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the secondary ip range that will be created for the k8s services"
  default = {
    dev = "subnet-dev-services"
    hml = "subnet-hml-services"
    prd = "subnet-prd-services"
  }
}

variable "secundary_ip_cidr_range_services" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ip range of the secondary ip range that will be created for the k8s services"
  default = {
    dev = "10.0.2.0/24"
    hml = "10.1.2.0/24"
    prd = "10.2.2.0/24"
  }
}

variable "subnet_region" {
  type        = string
  description = "The list of subnets being created"
  default     = "southamerica-east1"
}

/******************************************
	GKE variables
 *****************************************/
variable "cluster_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the network being created"
  default = {
    dev = "cluster-gke-dev"
    hml = "cluster-gke-hml"
    prd = "cluster-gke-prd"
  }
}




variable "gke_location" {
  type = object({
    dev = bool
    hml = bool
    prd = bool
  })
  description = "The name of the network being created"
  default = {
    dev = false
    hml = false
    prd = true
  }
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
  default     = "southamerica-east1"
}

variable "ip_range_services" {
  type        = string
  description = "The secondary ip range to use for services"
  default     = "k8s-range-services"
}

variable "default_max_pods_per_node" {
  type        = number
  description = "The maximum number of pods to schedule per node"
  default     = 110
}

variable "cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default = {
    managed = "terraform",
    enviroment = "dev"
  }
}

variable "enable_vertical_pod_autoscaling" {
  type        = bool
  description = ""
  default     = false
}

variable "http_load_balancing" {
  type        = bool
  description = ""
  default     = false
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  description = ""
  default     = false
}

variable "node_pools" {
  type = object({
    dev = list(map(string))
    hml = list(map(string))
    prd = list(map(string))
  })
  description = "The subnet name that postreg instance will be created"
  default = {
    dev = [{
      name              = "pool-dev",
      min_count         = 1,
      max_count         = 10,
      local_ssd_count   = 0,
      disk_size_gb      = 50,
      disk_type         = "pd-balanced",
      auto_repair       = true,
      auto_upgrade      = true,
      autoscaling       = true,
      node_count        = 2,
      machine_type      = "e2-medium",
      preemptible       = false,
      max_pods_per_node = 24
    }]
    hml = [{
      name              = "pool-hml",
      min_count         = 1,
      max_count         = 10,
      local_ssd_count   = 0,
      disk_size_gb      = 50,
      disk_type         = "pd-balanced",
      auto_repair       = true,
      auto_upgrade      = true,
      autoscaling       = true,
      node_count        = 2,
      machine_type      = "e2-standard-4",
      preemptible       = false,
      max_pods_per_node = 24
    }]
    prd = [{
      name              = "pool-prod",
      min_count         = 1,
      max_count         = 10,
      local_ssd_count   = 0,
      disk_size_gb      = 50,
      disk_type         = "pd-balanced",
      auto_repair       = true,
      auto_upgrade      = true,
      autoscaling       = true,
      node_count        = 4,
      machine_type      = "e2-standard-4",
      preemptible       = false,
      max_pods_per_node = 24
      }, {
      name              = "pool-prod-2",
      min_count         = 1,
      max_count         = 10,
      local_ssd_count   = 0,
      disk_size_gb      = 50,
      disk_type         = "pd-balanced",
      auto_repair       = true,
      auto_upgrade      = true,
      autoscaling       = true,
      node_count        = 4,
      machine_type      = "e2-standard-4",
      preemptible       = false,
      max_pods_per_node = 24
      }
    ]
  }
}


/******************************************
	PostgreSQL variables
 *****************************************/

variable "postgre_instance_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ip range to allow connecting from/to Cloud SQL"
  default = {
    dev = "postgre-dev-3"
    hml = "postgre-hml"
    prd = "postgre-prd"
  }
}

variable "database_version" {
  type        = string
  description = ""
  default     = "POSTGRES_9_6"
}

variable "postgre_machine_type" {
  type        = string
  description = ""
  default     = "db-custom-4-15360"

}

variable "postgre_zone" {
  type        = string
  description = ""
  default     = "southamerica-east1-b"
}

variable "postgre_availability_type" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The subnet name that postreg instance will be created"
  default = {
    dev = "ZONAL"
    hml = "ZONAL"
    prd = "REGIONAL"
  }
}



variable "subnet_name_postgre" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The subnet name that postreg instance will be created"
  default = {
    dev = "subnet-dev-postgre"
    hml = "subnet-hml-postgre"
    prd = "subnet-prd-postgre"
  }
}

##
variable "subnet_ip_postgre" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ip range to allow connecting from/to Cloud SQL"
  default = {
    dev = "10.10.0.0/24"
    hml = "10.11.0.0/24"
    prd = "10.12.0.0/24"
  }
}

# variable "database_name" {
#   type = object({
#     dev = string
#     hml = string
#     prd = string
#   })
#   description = "The name of the network being created"
#   default = {
#     dev = "database-dev-postgre"
#     hml = "database-hml-postgre"
#     prd = "database-prd-postgre"
#   }
# }


variable "disk_autoresize" {
  description = "Configuration to increase storage size."
  type        = bool
  default     = true
}

variable "disk_autoresize_limit" {
  description = "The maximum size to which storage can be auto increased."
  type        = number
  default     = 0
}

variable "disk_size" {
  description = "The disk size for the master instance."
  default     = 50
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}
/******************************************
	Redis variables
 *****************************************/

# variable "memorystore_zones" {
#   type        = list(string)
#   description = "Zones where memcache nodes should be provisioned. If not provided, all zones will be used."
#   default     = null
# }

variable "memorystore_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ID of the instance or a fully qualified identifier for the instance."
  default = {
    dev = "redis-dev"
    hml = "redis-hml"
    prd = "redis-prd"
  }
}


variable "memorystore_location_id" {
  type        = string
  description = "The ID of the instance or a fully qualified identifier for the instance."
  default     = "southamerica-east1-b"

}

variable "memorystore_alternative_location_id" {
  type        = string
  description = "The ID of the instance or a fully qualified identifier for the instance."
  default     = "southamerica-east1-c"
}

variable "redis_memory_size_gb" {
  type = object({
    dev = number
    hml = number
    prd = number
  })
  description = "The ID of the instance or a fully qualified identifier for the instance."
  default = {
    dev = 1
    hml = 1
    prd = 5
  }
}


variable "redis_replica_number" {
  type = object({
    dev = number
    hml = number
    prd = number
  })
  description = "The ID of the instance or a fully qualified identifier for the instance."
  default = {
    dev = null
    hml = null
    prd = 1
  }
}


variable "display_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ID of the instance or a fully qualified identifier for the instance."
  default = {
    dev = "redis-instance-dev"
    hml = "redis-instance-hml"
    prd = "redis-instance-prd"
  }
}

variable "memorystore_labels" {
  type        = map(string)
  description = ""
  default = {
    "managed" = "terraform",
    "enviroment" = "dev"
  }
}

/******************************************
  Artifact Registry variables
 *****************************************/

variable "artifact_registry_name" {
  type        = string
  description = ""
  default     = "vivae"
}

variable "artifact_registry_description" {
  type        = string
  description = ""
  default     = "vivae"
}

variable "artifact_registry_labels" {
  type        = map(string)
  description = ""
  default = {
    "managed" = "terraform"
  }
}

/******************************************
  Cloud Source Repository variables
 *****************************************/

variable "repository-name" {
  type        = string
  description = ""
  default     = "vivae"

}

/******************************************
  Cloud Storage variables
 *****************************************/

variable "bucket-name" {
  type        = string
  description = ""
  default     = "vivae-audit"

}

variable "storage_class" {
  type        = string
  description = ""
  default     = "STANDARD"

}

variable "versioning" {
  type        = string
  description = ""
  default     = true

}

variable "storage_labels" {
  type        = map(string)
  description = ""
  default = {
    "managed" = "terraform"
  }

}

# variable "retention_period" {
#   type        = number
#   description = ""
#   default     = 2592000

# }

variable "life_cycle_days" {
  type        = number
  description = ""
  default     = 360
}

variable "life_cycle_action" {
  type        = string
  description = ""
  default     = "Delete"

}

/******************************************
 Nat variables
 *****************************************/

variable "router_name" {
  type        = string
  description = ""
  default     = "router-name"
}

variable "nat_name" {
  type        = string
  description = ""
  default     = "nat-name"
}

/******************************************
 Endpoints variables
 *****************************************/


variable "endpoints_service_name" {
  type = string
  description = ""
  default = "echo-api.endpoints.vivae-poc.cloud.goog"
}

variable "api_file_path" {
  type = string
  description = ""
  default = "./endpoints_files/openapi.yaml"
}