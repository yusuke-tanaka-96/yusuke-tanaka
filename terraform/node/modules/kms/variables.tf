variable "kms_description" {
  description = "Description for kms"
  type        = string
}

variable "alias_name" {
  description = "Alias name for kms"
  type        = string
}

variable "deletion_window_in_days" {
  description = "Deletion window for KMS key"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic key rotation"
  type        = bool
  default     = true
}

variable "kms_policy" {
  description = "Policy for kms"
  type        = string
  default     = null
}

variable "merged_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
