variable "enabled" {
  description = "Flag to control whpf2er EventBridge resources are created"
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Prefix for naming"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Suffix for naming"
  type        = string
  default     = ""
}

variable "event_bus_name" {
  description = "Event bus name"
  type        = string
  default     = ""
}

variable "merged_tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
  default     = {}
}

variable "name_rule" {
  description = "event rule name"
  type        = string
  default     = ""
}

variable "schedule_expression" {
  description = "Schedule expression"
  type        = string
}

variable "target_arn" {
  description = "ARN of the target to be triggered."
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to be triggered."
  type        = string
  default     = ""
}

variable "event_pattern" {
  type    = string
  default = null
}

variable "role_arn" {
  type    = string
  default = null
}

variable "project_name" {
  description = "project name"
  type        = string
  default     = ""
}
