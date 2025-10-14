variable "name_prefix" {
  description = "Prefix for resource names (e.g., environment or project)"
  type        = string
}

variable "enable_default_standards" {
  description = "Whpf2er to enable the default standards for Security Hub"
  type        = bool
  default     = true
}

variable "control_finding_generator" {
  description = "Which controls generate findings (SECURITY_CONTROL or STANDARD_CONTROL)"
  type        = string
  default     = "SECURITY_CONTROL"
}

variable "auto_enable_controls" {
  description = "Whpf2er to automatically enable new controls"
  type        = bool
  default     = true
}

variable "standards_arns" {
  description = "List of Security Hub standards ARNs to enable"
  type        = list(string)
  default = [
    "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0",
    "arn:aws:securityhub:::ruleset/aws-foundational-security-best-practices/v/1.0.0"
  ]
}

variable "enable_finding_aggregator" {
  description = "Whpf2er to enable finding aggregator for multi-region aggregation"
  type        = bool
  default     = false
}

variable "aggregator_linking_mode" {
  description = "Linking mode for finding aggregator (ALL_REGIONS or SPECIFIED_REGIONS)"
  type        = string
  default     = "ALL_REGIONS"
}

variable "aggregator_regions" {
  description = "List of regions for finding aggregator when linking_mode is SPECIFIED_REGIONS"
  type        = list(string)
  default     = []
}

variable "merged_tags" {
  description = "Common tags to apply to Security Hub resources"
  type        = map(string)
  default     = {}
}
