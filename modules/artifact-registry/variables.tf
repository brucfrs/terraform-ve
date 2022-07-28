variable "name" {
  type = string
  description = ""
}

variable "region" {
  type = string
  description = ""
}

variable "description" {
  type = string
  description = ""
}

variable "format" {
  type = string
  description = ""
  default = "DOCKER"
}
variable "labels" {
  type = map(string)
  description = ""
}