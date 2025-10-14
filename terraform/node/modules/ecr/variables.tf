variable "repositories" {
  description = "List of ECR repository definitions"
  type = list(object({
    name                 = string
    image_tag_mutability = string
    encryption_type      = string
    kms_key              = string
    scan_on_push         = bool
    tags                 = map(string)
  }))
}
