
variable "router_name" {
  type = string
  description = ""
}

variable "region" {
  type = string
  description = ""
}

variable "vpc" {
  type = string
  description = ""
}

variable "bgp_asn" {
  type = number
  description = "" 
  default = 64514
}

variable "nat_name" {
  type = string
  description = ""
}

variable "nat_ip_allocate_option" {
      type = string

  default = "AUTO_ONLY"
}
variable "source_subnetwork_ip_ranges_to_nat" {
      type = string

  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "logs_enable" {
    type = bool
    description = ""
    default = true
}

variable "logs_filter" {
  type = string
  description = ""
  default = "ERRORS_ONLY"
}
