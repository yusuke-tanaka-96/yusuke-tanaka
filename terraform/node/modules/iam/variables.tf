variable "role_name" {
  description = "Name of the IAM Role"
  type        = string
  default     = null
}

variable "role_description" {
  description = "Description of the IAM Role"
  type        = string
  default     = null
}

variable "trusted_entities" {
  description = "Trusted entities for the IAM Role (e.g., s3.amazonaws.com, ec2.amazonaws.com)"
  type        = list(string)
  default     = []
}

variable "policy_statements" {
  description = "List of IAM policy statements"
  type        = string
  default     = ""
}

variable "inline_policies" {
  description = "List of inline IAM policies"
  type = list(object({
    name    = string
    content = string
  }))
  default = []
}

variable "assume_role_policy" {
  description = "List of assume IAM policies"
  type = list(object({
    name    = string
    content = string
  }))
  default = []
}


variable "tags" {
  description = "Tags for the IAM Role"
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
  default     = ""
}

# タグ
variable "merged_tags" {
  description = "Merged tags for resources"
  type        = map(string)
  default     = {}
}

variable "policy_arns" {
  description = "List of AWS Managed Policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "create_instance_profile" {
  description = "Whpf2er to create an IAM instance profile"
  type        = bool
  default     = false
}

variable "federated_entities" {
  description = "List of federated principals for sts:AssumeRole"
  type        = list(string)
  default     = []
}

variable "aws_entities" {
  description = "List of AWS principals (ARNs) for sts:AssumeRole"
  type        = list(string)
  default     = []
}

variable "service_condition" {
  description = "condition for sts:AssumeRole"
  type        = any
  default     = {}
}

variable "federated_action" {
  description = "action of Federated principals"
  type        = list(string)
  default     = []
}

variable "federated_condition" {
  description = "condition for Federated"
  type        = any
  default     = {}
}


