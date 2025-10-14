variable "name_prefix" {
  type        = string
  description = "Prefix for WAF resource name"
}

variable "name_suffix" {
  type        = string
  description = "Suffix for WAF resource name"
}

variable "merged_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply"
}

variable "description" {
  type        = string
  default     = "WAF Web ACL managed by Terraform"
  description = "WAF description"
}

variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = "Scope: REGIONAL (ALB/API GW) or CLOUDFRONT"
}

variable "associate_arn" {
  type        = string
  default     = ""
  description = "ARN of resource to associate (e.g. ALB, API Gateway)"
}

variable "enable_managed_rule" {
  type        = bool
  default     = true
  description = "Enable AWSManagedRulesCommonRuleSet"
}

variable "enable_rate_limit" {
  type        = bool
  default     = true
  description = "Enable rate limit rule"
}

variable "rate_limit" {
  type        = number
  default     = 2000
  description = "Rate limit per 5 minutes per IP"
}

variable "enable_association" {
  type        = bool
  default     = false
  description = "Whpf2er to associate the WAF with a resource"
}

variable "whitelist_ips" {
  type    = list(string)
  default = []
}

variable "custom_rules" {
  description = "A list of custom rules for path-based access control."
  type = list(object({
    name             = string
    path_starts_with = string
    priority         = number
    default_action   = string
  }))
  default = []

  validation {
    condition = length(var.custom_rules) == length(distinct([
      for r in var.custom_rules : r.priority
    ]))
    error_message = "custom_rules priority values must be unique."
  }
}
