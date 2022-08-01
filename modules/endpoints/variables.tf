variable "service_name" {
  type = string
  description = ""
  default = "echo-api.endpoints.vivae-poc.cloud.goog"
}

variable "project_id" {
  type = string
  description = ""
}

variable "api_file_path" {
  type = string
  description = ""
  default = "../../endpoints_files/openapi.yaml"
}