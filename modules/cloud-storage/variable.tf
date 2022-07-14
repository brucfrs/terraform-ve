variable "name" {
    type = string
    description = ""
}

variable "project_id" {
  type = string
  description = ""
}

variable "region" {
    type = string
    description = ""
}
variable "force_destroy" {
    type = bool
    description = ""
    default = true
}
variable "storage_class" {
    type = string
    description = ""
}
variable "versioning" {
    type = string
    description = ""
}
variable "labels" {
    type = map(string)
    description = ""
}
variable "uniform_bucket_level_access" {
    type = string
    description = ""
    default = false
}
# variable "retention_period" {
#     type = number
#     description = ""
# }
variable "age" {
    type = number
    description = ""
}
variable "action" {
  type = string
  description = ""
}