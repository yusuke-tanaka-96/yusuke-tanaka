variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "aws_account" {
  description = "AWS account ID"
  type        = string
}

variable "resource_types" {
  description = "Inspector resource types to scan"
  type        = list(string)
  default     = ["EC2", "ECR", "LAMBDA"]
}

variable "merged_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}