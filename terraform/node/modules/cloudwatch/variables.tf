variable "name_prefix" {
  description = "Prefix for naming (e.g. environment or service)"
  type        = string
  default     = ""
} # TODO: 利用していない（ただ、ここを削除すると全環境に影響がでるため、コメントのみ追記）

variable "name_suffix" {
  description = "Suffix for naming (e.g. component or purpose)"
  type        = string
  default     = ""
} # TODO: 利用していない（ただ、ここを削除すると全環境に影響がでるため、コメントのみ追記）

variable "retention_in_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}

variable "merged_tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

# CloudWatch Logs ロググループ名
variable "log_group_name" {
  description = "The name of the CloudWatch Logs log group."
  type        = string
}

# KMSキーのARN
variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encrypting the log group. If empty, the log group will not be encrypted."
  type        = string
}
