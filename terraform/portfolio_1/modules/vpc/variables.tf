# AWSリージョン
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Whpf2er to create and manage resources in this VPC module"
  type        = bool
  default     = true
}

# サブネットCIDR設定
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for Public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for Private subnets"
  type        = list(string)
  default     = []
}

variable "protect_subnet_cidrs" {
  description = "List of CIDR blocks for Protect subnets"
  type        = list(string)
  default     = []
}

# サブネット名設定
variable "public_subnet_names" {
  description = "List of CIDR blocks for Public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnet_names" {
  description = "List of CIDR blocks for Private subnets"
  type        = list(string)
  default     = []
}

variable "protect_subnet_names" {
  description = "List of CIDR blocks for Protect subnets"
  type        = list(string)
  default     = []
}

# アベイラビリティゾーン
variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = []
}

variable "nat_gateway_subnet_ids" {
  description = "The subnet ID for NAT Gateway. If not specified, no NAT Gateway will be created."
  type        = list(string)
  default     = []
}

# ピアリング接続先VPCのID
variable "peer_vpc_id" {
  description = "VPC ID of the peer VPC"
  type        = string
  default     = ""
}

# ピアリング接続先VPCのCIDRブロック
variable "peer_vpc_cidrs" {
  description = "List of CIDR blocks of the peer VPC for routing"
  type        = list(string)
  default     = []
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

variable "s3_log_bucket_arn" {
  description = "ARN of the S3 bucket to store VPC flow logs"
  type        = string
  default     = ""
}

variable "s3_log_prefix" {
  description = "Prefix for S3 logs (VPC flow logs, etc.)"
  type        = string
  default     = ""
}


variable "iam_role_arn" {
  description = "ARN of the iam role for VPC flow logs"
  type        = string
  default     = ""
}

variable "create_security_groups" {
  description = "Whpf2er to create the security groups"
  type        = bool
  default     = false
}


variable "security_groups" {
  description = "List of security groups to create. Each group is a map with 'name', 'description', 'ingress', and 'egress'."
  type = list(object({
    name        = string
    description = string
    ingress = optional(list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
      prefix_list_ids = optional(list(string))
    })))
    egress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
      prefix_list_ids = optional(list(string))
    }))
  }))
  default = []
}

variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
  default     = ""
}

variable "cloudwatch_subnet_ids" {
  description = "List of Subnet IDs for CloudWatch and CloudWatch Logs endpoints"
  type        = list(string)
  default     = []
}

variable "nacl_rules" {
  description = "List of NACL rules to create"
  type = list(object({
    name        = string
    description = string
    subnet_ids      = optional(list(string))
    subnet_selector = optional(string)
    ingress = list(object({
      rule_number = number
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_block  = string
      rule_action = string
    }))
    egress = list(object({
      rule_number = number
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_block  = string
      rule_action = string
    }))
  }))
  default = []
}

variable "cloudwatch_logs_endpoint_subnet_ids" {
  description = "List of subnet IDs for CloudWatch Logs endpoint"
  type        = list(string)
  default     = []
}

variable "api_gateway_endpoint_subnet_ids" {
  description = "List of subnet IDs for CloudWatch Monitoring endpoint"
  type        = list(string)
  default     = []
}

variable "s3_endpoint_subnet_ids" {
  description = "List of subnet IDs for S3 Gateway endpoint"
  type        = list(string)
  default     = []
}

variable "igw_name" {
  description = "name of internet gateway"
  type        = string
  default     = ""
}

variable "vpc_ep_s3_name" {
  description = "name of vpc endpoint s3"
  type        = string
  default     = ""
}

variable "ssm_endpoint_subnet_ids" {
  description = "List of subnet IDs to place the SSM endpoints"
  type        = list(string)
  default     = []
}

variable "ssm_endpoint_sg_ids" {
  description = "List of SG IDs to place the SSM endpoints"
  type        = list(string)
  default     = []
}

variable "public_route_table_id" {
  description = "public route table id"
  type        = string
  default     = ""
}

variable "private_route_table_id" {
  description = "private route table id"
  type        = string
  default     = ""
}

variable "flow_log_bucket" {
  description = "ARN of the S3 bucket to store VPC flow logs"
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch" {
  description = "the Cloudwatch log group to store VPC flow logs"
  type        = string
  default     = ""
}

variable "sg_db_name" {
  description = "sg name of database"
  type        = string
  default     = ""
}

variable "secretsmanager_endpoint_subnet_ids" {
  description = "secrets manager endpoint subnet ids"
  type        = list(string)
  default     = []
}

variable "sg_modify" {
  description = "List of security groups to modify, each with optional ingress and egress rules"
  type = list(object({
    security_group_id = string
    ingress = optional(list(object({
      description              = optional(string)
      from_port                = number
      to_port                  = number
      protocol                 = string
      cidr_blocks              = optional(list(string))
      source_security_group_id = optional(string)
    })))
    egress = optional(list(object({
      description              = optional(string)
      from_port                = number
      to_port                  = number
      protocol                 = string
      cidr_blocks              = optional(list(string))
      source_security_group_id = optional(string)
    })))
  }))
  default = []
}
