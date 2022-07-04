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
  description = "The name of the subnet that will be created"
}

variable "subnet_ip" {
  type        = string
  description = "The Ip Range of the subnet that will be created"
}

variable "secundary_range_name_k8s" {
  type        = string
  description = "The name of the secondary ip range that will be created for the k8s pods"
}

variable "secundary_ip_cidr_range_k8s" {
  type        = string
  description = "The ip range of the secondary ip range that will be created for the k8s pods"
}

variable "secundary_range_name_services" {
  type        = string
  description = "The name of the secondary ip range that will be created for the k8s services"
}

variable "secundary_ip_cidr_range_services" {
  type        = string
  description = "The ip range of the secondary ip range that will be created for the k8s services"
}

variable "subnet_region" {
  type        = string
  description = "The region where the subnet will be created"
}

