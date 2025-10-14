variable "enabled" {
  description = "Control whpf2er this module manages any resources"
  type        = bool
  default     = true
}

variable "zone_name" {
  description = "Route53 Hosted Zone name"
  type        = string
  default     = ""
}

variable "vpc_ids" {
  description = "List of VPC IDs to associate with the private hosted zone (if applicable)"
  type        = list(string)
  default     = []
}

variable "hosted_zone_type" {
  description = "Type of hosted zone: public or private"
  type        = string
  default     = "public"
}

variable "records" {
  description = "List of Route53 records"
  type = list(object({
    name    = string
    type    = string
    ttl     = optional(number)
    records = optional(list(string))
    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool, false)
    }))
  }))
  default = []
}

variable "zone_id" {
  description = "指定するホストゾーンID。指定しない場合はaws_route53_zone.this.zone_idを使用。"
  type        = string
  default     = ""
}
