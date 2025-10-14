output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value = var.enabled ? (
    var.certificate_authority_arn != null ?
    aws_acm_certificate.private[0].arn :
    aws_acm_certificate.this[0].arn
  ) : null
}

output "certificate_domain" {
  description = "Domain name of the ACM certificate"
  value       = var.enabled ? var.domain_name : null
}
