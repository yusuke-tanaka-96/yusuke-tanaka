output "parameter_arn" {
  value = aws_ssm_parameter.this.arn
}

output "parameter_name" {
  value = aws_ssm_parameter.this.name
}

output "document_arn" {
  value = var.create_document ? aws_ssm_document.this[0].arn : null
}

output "document_name" {
  value = var.create_document ? aws_ssm_document.this[0].name : null
}