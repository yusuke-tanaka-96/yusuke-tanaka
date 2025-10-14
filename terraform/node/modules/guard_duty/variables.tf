variable "name_prefix" {
  description = "Prefix for resource names (e.g., environment or project)"
  type        = string
}

variable "enable_detector" {
  description = "Whpf2er to enable the GuardDuty detector"
  type        = bool
  default     = true
}

variable "enable_s3_protection" {
  description = "Whpf2er to enable S3 data source protection"
  type        = bool
  default     = true
}

variable "enable_eks_protection" {
  description = "Whpf2er to enable EKS audit log protection"
  type        = bool
  default     = false
}

variable "enable_malware_protection" {
  description = "Whpf2er to enable malware protection for EC2 instances"
  type        = bool
  default     = false
}

variable "enable_publishing_destination" {
  description = "Whpf2er to enable publishing GuardDuty findings to an S3 bucket"
  type        = bool
  default     = false
}

variable "destination_s3_arn" {
  description = "ARN of the S3 bucket for publishing GuardDuty findings"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for encrypting GuardDuty findings"
  type        = string
  default     = ""
}

variable "merged_tags" {
  description = "Common tags to apply to GuardDuty resources"
  type        = map(string)
  default     = {}
}
