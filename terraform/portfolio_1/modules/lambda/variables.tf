variable "enabled" {
  description = "Flag to control whpf2er the Lambda resources are created"
  type        = bool
  default     = true
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role ARN for Lambda"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket containing the Lambda source code"
  type        = string
  default     = ""
}

variable "s3_key" {
  description = "S3 key (object path) of the Lambda zip file"
  type        = string
  default     = ""
}

variable "s3_object_version" {
  description = "S3 object version (optional)"
  type        = string
  default     = null
}

variable "local_zip_path" {
  description = "Path to the local ZIP file for Lambda deployment. If specified, S3 arguments are ignored."
  type        = string
  default     = ""
}

variable "environment_variables" {
  description = "environment variables"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "timeout" {
  description = "Timeout for the Lambda function"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
  default     = 128
}

variable "architectures" {
  description = "value"
  type        = list(string)
  default     = ["x86_64"]
}

variable "phemeral_storage_size" {
  description = "size of phemeral storage"
  type        = number
  default     = 512
}

variable "subnet_ids" {
  description = "list of subnet ids"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "list of security group ids"
  type        = list(string)
  default     = []
}
variable "log_group" {
  description = "name of log group"
  type        = string
  default     = ""
}

variable "package_type" {
  description = "package type"
  type        = string
  default     = "Zip"
}

variable "reserved_concurrent_executions" {
  description = "reserved concurrent executions"
  type        = string
  default     = "-1"
}

variable "skip_destroy" {
  description = "skip destroy"
  type        = string
  default     = "false"
}

# タグ
variable "merged_tags" {
  description = "Merged tags for resources"
  type        = map(string)
  default     = {}
}

variable "layer_arns" {
  type        = list(string)
  default     = []
  description = "Lambda にアタッチするレイヤーARNの一覧"
}

variable "invoke_permissions" {
  description = "aws_lambda_permission の一覧"
  type = list(object({
    statement_id   = string
    principal      = string
    action         = optional(string, "lambda:InvokeFunction")
    source_arn     = optional(string)
    source_account = optional(string)
    qualifier      = optional(string)
  }))
  default = []
}
