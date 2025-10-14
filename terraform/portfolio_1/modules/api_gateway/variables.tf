variable "name_prefix" {
  type = string
}

variable "merged_tags" {
  type = map(string)
}

variable "rest_api_name" {
  type = string
}

variable "stage_name" {
  type = string
}

variable "nlb_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "lambda_filename" {
  type = string
}

variable "lambda_handler" {
  type    = string
  default = "bootstrap"
}

variable "lambda_runtime" {
  type    = string
  default = "go1.x"
}
