variable "name_prefix" {
  description = "Prefix for the AWS Config resource names (e.g., environment or project)"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the existing S3 bucket for AWS Config logs"
  type        = string
}

variable "config_role_arn" {
  description = "ARN of the IAM role for AWS Config"
  type        = string
}

variable "all_supported" {
  description = "Whpf2er to record all supported resource types"
  type        = bool
  default     = true
}

variable "include_global_resource_types" {
  description = "Whpf2er to include global resource types (e.g., IAM)"
  type        = bool
  default     = true
}

variable "enable_recording" {
  description = "Whpf2er to enable AWS Config recording"
  type        = bool
  default     = true
}

variable "s3_key_prefix" {
  description = "Optional S3 key prefix for AWS Config logs"
  type        = string
  default     = "AWSConfig"
}

variable "sns_topic_arn" {
  description = "Optional ARN of the SNS topic for AWS Config notifications"
  type        = string
  default     = ""
}

variable "iam_role_arn" {
  description = "ARN of the IAM role for AWS Config"
  type        = string
  default     = ""

}

variable "merged_tags" {
  description = "Common tags to apply to AWS Config resources"
  type        = map(string)
  default     = {}
}
