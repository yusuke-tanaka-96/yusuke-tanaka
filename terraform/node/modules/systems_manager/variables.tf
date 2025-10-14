variable "name_prefix" {
  description = "Prefix for the parameter and document names (e.g., environment or project)"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Suffix for the parameter and document names (e.g., purpose or service name)"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the SSM parameter"
  type        = string
  default     = ""
}

variable "parameter_type" {
  description = "Type of SSM parameter (String, StringList, SecureString)"
  type        = string
  default     = "String"
}

variable "parameter_value" {
  description = "Value of the SSM parameter"
  type        = string
  sensitive   = true
}

variable "create_document" {
  description = "Whpf2er to create an SSM document"
  type        = bool
  default     = false
}

variable "document_type" {
  description = "Type of SSM document (e.g., Command, Policy, Automation)"
  type        = string
  default     = "Command"
}

variable "document_content" {
  description = "Content of the SSM document in YAML format"
  type        = string
  default     = ""
}

variable "merged_tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}
