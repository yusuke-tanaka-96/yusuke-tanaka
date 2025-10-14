variable "name_prefix" {
  type = string
}

variable "environment" {
  type    = string
  default = null
}

variable "synced_tag_value" {
  description = "The value of the tag to identify the EBS volumes for backup."
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role to use for the DLM policy."
  type        = string
}

variable "create_rule_interval" {
  description = "The interval of create rule."
  type        = number
}

variable "create_rule_interval_unit" {
  description = "The interval unit of create rule."
  type        = string
}

variable "retain_rule_interval" {
  description = "The interval of the retain rule."
  type        = number
}

variable "retain_rule_interval_unit" {
  description = "The interval unit of retain rule."
  type        = string
}
