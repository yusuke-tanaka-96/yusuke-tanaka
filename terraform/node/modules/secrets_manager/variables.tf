variable "name_prefix" {
  description = "Prefix for the secret name (e.g. environment or project)"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Suffix for the secret name (e.g. purpose or service name)"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = ""
}

variable "secret_string" {
  description = "The secret content in JSON string format"
  type        = string
}

variable "merged_tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "rotation_lambda_arn" {
  type        = string
  default     = ""
  description = "ローテーションを実行するLambda関数のARN"
}

variable "rotation_days" {
  type        = number
  default     = 90
  description = "ローテーション間隔（日）※1〜1000"
}
