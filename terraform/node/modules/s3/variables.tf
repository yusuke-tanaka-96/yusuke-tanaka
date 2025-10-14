variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning for S3 bucket"
  type        = bool
  default     = false
}

variable "enable_object_lock" {
  description = "Enable Object Lock for S3 bucket"
  type        = bool
  default     = false
}

variable "server_access_logging" {
  description = "Enable server access logging"
  type        = bool
  default     = false
}

variable "bucket_policy" {
  description = "S3 bucket policy"
  type        = string
  default     = ""
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for S3 bucket"
  type = list(object({
    id                        = string
    status                    = string
    prefix                    = string
    expiration_days           = optional(number, null)
    newer_noncurrent_versions = optional(number, null)
    noncurrent_days           = optional(number, null)
  }))
  default = []
}


variable "replication_rules" {
  description = "Replication rules for S3 bucket"
  type = list(object({
    id          = string
    prefix      = string
    destination = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to be applied to the S3 bucket"
  type        = map(string)
  default     = {}
}

# ネームプレフィックス
variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = ""
}

# ネームサフィックス
variable "name_suffix" {
  description = "suffix for naming resources"
  type        = string
  default     = "logs-bucket"
}

# タグ
variable "merged_tags" {
  description = "Merged tags for resources"
  type        = map(string)
  default     = {}
}

variable "replication_role_arn" {
  description = "IAM Role ARN for S3 Replication"
  type        = string
  default     = null
}

variable "replication_destination_bucket_arn" {
  description = "ARN of the destination S3 bucket for replication"
  type        = string
  default     = null
}

variable "replication_storage_class" {
  description = "S3 storage class for replicated objects"
  type        = string
  default     = "STANDARD"
}

variable "folder_name" {
  description = "The name of the folder to create inside the S3 bucket."
  type        = string
  default     = ""
}

variable "object_ownership" {
  description = "Object ownership controls for S3 bucket"
  type        = string
  default     = ""
}

variable "enable_partitioned_logging" {
  description = "Enable partitioned prefix for S3 access logging"
  type        = bool
  default     = false
}

variable "access_log_prefix" {
  description = "Prefix for S3 access logs"
  type        = string
  default     = "S3AccessLogs/"
}
