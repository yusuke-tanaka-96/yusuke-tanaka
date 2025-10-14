output "kms_key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.this.arn
}

output "kms_key_id" {
  description = "ID of the KMS key"
  value       = aws_kms_key.this.key_id
}

output "kms_alias_name" {
  description = "Name of the KMS alias"
  value       = aws_kms_alias.this.name
}