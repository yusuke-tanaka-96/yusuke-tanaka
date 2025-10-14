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

variable "role_arn" {
  description = "IAM Role ARN for Step Functions execution"
  type        = string
}

variable "definition" {
  description = "State machine definition in JSON"
  type        = string
}

variable "state_machine_type" {
  description = "STANDARD or EXPRESS"
  type        = string
  default     = "STANDARD"
}

variable "merged_tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "enable_logging" {
  description = "Enable CloudWatch logging for Step Functions"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "log_level" {
  description = "Logging level (ALL, ERROR, FATAL, OFF)"
  type        = string
  default     = "ALL"
}

variable "include_execution_data" {
  description = "Include execution data in logs"
  type        = bool
  default     = true
}
