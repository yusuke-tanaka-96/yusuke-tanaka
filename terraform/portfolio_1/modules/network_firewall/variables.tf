variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "name_suffix" {
  description = "Suffix for resource names"
  type        = string
}

variable "description" {
  description = "Description for the Network Firewall and Rule Group"
  type        = string
  default     = "Network Firewall managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC where the firewall will be deployed"
  type        = string
}

variable "subnet_mapping" {
  description = "List of subnet IDs for firewall endpoints"
  type        = list(string)
}

variable "rule_group_capacity" {
  description = "Capacity of the rule group"
  type        = number
  default     = 100
}

variable "rule_group_type" {
  description = "Type of rule group (STATELESS or STATEFUL)"
  type        = string
  default     = "STATELESS"
}

variable "stateful_rules" {
  description = "List of stateful rules for the rule group"
  type = list(object({
    action           = string
    protocol         = number
    source           = string
    source_port      = string
    direction        = string
    destination      = string
    destination_port = string
    sid              = string
  }))
  default = []

}

variable "source_cidr" {
  description = "Source CIDR block for stateless rules"
  type        = string
  default     = "0.0.0.0/0"
}

variable "destination_cidr" {
  description = "Destination CIDR block for stateless rules"
  type        = string
  default     = "0.0.0.0/0"
}

variable "protocols" {
  description = "List of protocols for stateless rules (e.g., [6] for TCP)"
  type        = list(number)
  default     = []
}

variable "stateless_actions" {
  description = "Actions for stateless rules"
  type        = list(string)
  default     = ["aws:pass"]
}

variable "stateless_default_actions" {
  description = "Default actions for stateless rules"
  type        = list(string)
  default     = ["aws:pass"]
}

variable "stateless_fragment_default_actions" {
  description = "Default actions for stateless fragment rules"
  type        = list(string)
  default     = ["aws:pass"]
}

variable "enable_logging" {
  description = "Enable logging for the Network Firewall"
  type        = bool
  default     = false
}

variable "log_destination" {
  description = "Log destination configuration (e.g., S3 bucket, CloudWatch Logs)"
  type        = map(string)
  default     = {}
}

variable "log_type" {
  description = "Type of logs to capture (e.g., ALERT, FLOW)"
  type        = string
  default     = "FLOW"
}

variable "log_destination_type" {
  description = "Type of log destination (e.g., S3, CloudWatchLogs)"
  type        = string
  default     = "S3"
}

variable "merged_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}