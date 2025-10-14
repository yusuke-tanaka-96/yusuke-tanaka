resource "aws_route53_resolver_firewall_domain_list" "this" {
  name    = "${var.name_prefix}-${var.name_suffix}-domain-list"
  domains = var.domains

  tags = var.merged_tags
}

resource "aws_route53_resolver_firewall_rule_group" "this" {
  name = "${var.name_prefix}-${var.name_suffix}-rule-group"

  tags = var.merged_tags
}

resource "aws_route53_resolver_firewall_rule" "this" {
  for_each = { for idx, rule in var.firewall_rules : idx => rule }

  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.this.id
  name                    = "${var.name_prefix}-${var.name_suffix}-rule-${each.key}"
  action                  = each.value.action
  priority                = each.value.priority
  firewall_domain_list_id = aws_route53_resolver_firewall_domain_list.this.id
  block_response          = each.value.block_response
  block_override_domain   = each.value.block_override_domain
  block_override_ttl      = each.value.block_override_ttl
}

resource "aws_route53_resolver_firewall_rule_group_association" "this" {
  name                   = "${var.name_prefix}-${var.name_suffix}-association"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.this.id
  vpc_id                 = var.vpc_id
  priority               = var.association_priority

  tags = var.merged_tags
}