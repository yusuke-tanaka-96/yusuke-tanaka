variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "name_suffix" {
  description = "Suffix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to associate with the DNS Firewall"
  type        = string
}

variable "domains" {
  description = "List of domains for the DNS Firewall domain list"
  type        = list(string)
  default     = []
}

variable "firewall_rules" {
  description = "List of DNS Firewall rules"
  type = list(object({
    action                = string
    priority              = number
    block_response        = string
    block_override_domain = string
    block_override_ttl    = number
  }))
  default = []
}

variable "association_priority" {
  description = "Priority for the firewall rule group association"
  type        = number
  default     = 100
}

variable "merged_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}