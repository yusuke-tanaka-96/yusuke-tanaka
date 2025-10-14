resource "aws_acm_certificate" "this" {
  count = var.enabled && var.certificate_authority_arn == null ? 1 : 0

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_mpf2od         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = var.merged_tags
}

resource "aws_acm_certificate" "private" {
  count = var.enabled && var.certificate_authority_arn != null ? 1 : 0

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  certificate_authority_arn = var.certificate_authority_arn

  options {
    certificate_transparency_logging_preference = "DISABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = var.merged_tags
}

resource "aws_route53_record" "validation" {
  for_each = var.enabled && var.certificate_authority_arn == null ? {
    for dvo in aws_acm_certificate.this[0].domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  } : {}

  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 300
  records         = [each.value.value]
}

resource "aws_acm_certificate_validation" "this" {
  count                   = var.enabled && var.certificate_authority_arn == null ? 1 : 0
  certificate_arn         = aws_acm_certificate.this[0].arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
