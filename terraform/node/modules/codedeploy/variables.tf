variable "app_name" {
  type = string
}

variable "service_role_arn" {
  type = string
}

variable "deployment_groups" {
  type = list(object({
    deployment_group_name = string
    cluster_name          = string
    service_name          = string
    listener_arns         = list(string)
    target_group_blue     = string
    target_group_green    = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
