variable "enabled" {
  description = "Control whpf2er ACM resources should be created"
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional domain names for the certificate"
  type        = list(string)
  default     = []
}

variable "merged_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "hosted_zone_id" {
  description = "Route53 zone ID for DNS validation. Required only for public certificates."
  type        = string
  default     = null
}

variable "certificate_authority_arn" {
  description = "ARN of the ACM Private CA to use. If null, a public certificate is requested."
  type        = string
  default     = null
}
