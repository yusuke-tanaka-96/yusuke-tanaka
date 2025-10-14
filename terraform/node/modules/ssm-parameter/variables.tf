# ------------------------------------------------------------
# 入力変数の定義
# ------------------------------------------------------------

# variable "name" {
#   description = "The name of the parameter."
#   type        = string
# }

# variable "description" {
#   description = "A description of the parameter."
#   type        = string
#   default     = ""
# }

# variable "type" {
#   description = "Type of the parameter. Valid types are String, StringList, and SecureString."
#   type        = string
#   default     = "String"
# }

# variable "value" {
#   description = "The value of the parameter."
#   type        = string
# }

# variable "overwrite" {
#   description = "Overwrite an existing parameter."
#   type        = bool
#   default     = true
# }

# variable "tags" {
#   description = "Tags to associate with the parameter."
#   type        = map(string)
#   default     = {}
# }

variable "ssm_parameters" {
  description = "List of ssm  parameters."
  type = list(object({
    name        = string
    description = string
    type        = string
    value       = string
    overwrite   = string
  }))
  default = []
}