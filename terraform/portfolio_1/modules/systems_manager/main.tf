resource "aws_ssm_parameter" "this" {
  name        = "${var.name_prefix}-${var.name_suffix}"
  description = var.description
  type        = var.parameter_type
  value       = var.parameter_value
  tags        = var.merged_tags
}

resource "aws_ssm_document" "this" {
  count = var.create_document ? 1 : 0

  name            = "${var.name_prefix}-ssm-document-${var.name_suffix}"
  document_type   = var.document_type
  document_format = "YAML"
  content         = var.document_content
  tags            = var.merged_tags
}