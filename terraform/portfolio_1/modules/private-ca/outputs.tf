output "ca_arn" {
  value       = aws_acmpca_certificate_authority.this.arn
  description = "CA ARN"
}

output "ca_type" {
  value       = aws_acmpca_certificate_authority.this.type
  description = "ROOT or SUBORDINATE"
}

output "csr_pem" {
  value       = aws_acmpca_certificate_authority.this.certificate_signing_request
  description = "CA の CSR（外部で署名する場合に使用）"
  sensitive   = true
}

output "certificate_pem" {
  value = try(
    aws_acmpca_certificate.root_self_signed[0].certificate,
    aws_acmpca_certificate.sub_signed_by_parent[0].certificate,
    null
  )
  description = "自動発行した CA 証明書（自動有効化時）"
  sensitive   = true
}

output "certificate_chain_pem" {
  value       = try(aws_acmpca_certificate.sub_signed_by_parent[0].certificate_chain, null)
  description = "自動発行した Subordinate のチェーン（親経由で発行した場合）"
  sensitive   = true
}
