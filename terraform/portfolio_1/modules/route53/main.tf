locals {
  effective_zone_id = var.zone_id != "" ? var.zone_id : (length(aws_route53_zone.this) > 0 ? aws_route53_zone.this[0].zone_id : "")
}

resource "aws_route53_zone" "this" {
  count = var.enabled && var.zone_name != "" ? 1 : 0
  name  = var.zone_name

  dynamic "vpc" {
    for_each = var.hosted_zone_type == "private" ? var.vpc_ids : []
    content {
      vpc_id = vpc.value
    }
  }

  comment       = "Managed by Terraform"
  force_destroy = true
}

resource "aws_route53_record" "this" {
  for_each = var.enabled ? {
    for record in var.records : "${record.name}_${record.type}" => record
  } : {}

  zone_id = local.effective_zone_id
  name    = each.value.name
  type    = each.value.type

  ttl     = lookup(each.value, "ttl", null)
  records = lookup(each.value, "records", null)

  dynamic "alias" {
    for_each = each.value.alias != null ? [1] : []
    content {
      name                   = each.value.alias.name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = each.value.alias.evaluate_target_health
    }
  }
}
