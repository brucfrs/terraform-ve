/******************************************
	Subnet variables
 *****************************************/
variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "network_name" {
  type        = string
  description = "The name of the network where subnets will be created"
}

variable "subnet_name" {
  type        = string
  description = "The list of subnets being created"
}

variable "subnet_ip" {
  type        = string
  description = "The list of subnets being created"
}

variable "secundary_range_name_k8s" {
  type        = string
  description = "The list of subnets being created"
}

variable "secundary_ip_cidr_range_k8s" {
  type        = string
  description = "The list of subnets being created"
}

variable "secundary_range_name_services" {
  type        = string
  description = "The list of subnets being created"
}

variable "secundary_ip_cidr_range_services" {
  type        = string
  description = "The list of subnets being created"
}

variable "subnet_region" {
  type        = string
  description = "The list of subnets being created"
}

