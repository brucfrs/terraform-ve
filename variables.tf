variable "project_id" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ID of the project where this VPC will be created"
  default = {
    dev = "terraform-dev-354612"
    hml = "vivae-hml"
    prd = "terraform-prd-354612"
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
    prd = "terraform-prd.json"
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
  default     = "us-east1"
}

/******************************************
	GKE variables
 *****************************************/
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
  default     = "us-east1"
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

variable "compute_engine_service_account" {
  type        = string
  description = "Service account to associate to the nodes in the cluster"
  default     = ""
}

variable "cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default = {
    managed = "terraform"
  }
}

/******************************************
	PostgreSQL variables
 *****************************************/

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

variable "subnet_ip_postgre" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The ip range to allow connecting from/to Cloud SQL"
  default = {
    dev = "10.10.0.0/"
    hml = "10.11.0.0/24"
    prd = "10.12.0.0/24"
  }
}

variable "database_name" {
  type = object({
    dev = string
    hml = string
    prd = string
  })
  description = "The name of the network being created"
  default = {
    dev = "database-dev-postgre"
    hml = "database-hml-postgre"
    prd = "database-prd-postgre"
  }
}


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