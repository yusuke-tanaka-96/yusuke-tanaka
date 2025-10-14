variable "name_prefix" {
  description = "Prefix for the CloudTrail trail name (e.g., environment or project)"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the existing S3 bucket for CloudTrail logs"
  type        = string
}

variable "include_global_service_events" {
  description = "Whpf2er to include global service events in CloudTrail"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Whpf2er the trail is multi-regiaon"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Whpf2er to enable logging for CloudTrail"
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  description = "Whpf2er to enable log file validation for CloudTrail"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "Optional KMS key ID for CloudTrail log encryption"
  type        = string
  default     = ""
}

variable "cloudwatch_role_arn" {
  description = "ARN of the IAM role for CloudWatch Logs integration"
  type        = string
  default     = ""
}

variable "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for CloudTrail logs"
  type        = string
  default     = ""
}

variable "event_selector_read_write_type" {
  description = "Read/write type for CloudTrail event selector (All, ReadOnly, WriteOnly)"
  type        = string
  default     = "All"
}

variable "include_management_events" {
  description = "Whpf2er to include management events in the event selector"
  type        = bool
  default     = true
}

variable "merged_tags" {
  description = "Common tags to apply to the CloudTrail trail"
  type        = map(string)
  default     = {}
}

variable "s3_key_prefix" {
  description = "Prefix for the S3 bucket for CloudTrail logs"
  type        = string
  default     = ""
}

variable "s3_data_event_buckets" {
  description = "List of S3 bucket names to log object-level operations"
  type        = list(string)
  default     = []
}
