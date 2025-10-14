
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "service_name" {
  description = "The VPC endpoint service name (e.g., vpce-svc-xxxxxx)"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the endpoint"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "private_dns_enabled" {
  description = "Whpf2er to enable private DNS"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}


variable "name_prefix" {
  description = "Prefix for resource naming (e.g., 'prod', 'dev', 'test')"
  type        = string
}

variable "name_suffix" {
  description = "Suffix for resource naming (e.g., '001', 'main', 'backup')"
  type        = string
}



