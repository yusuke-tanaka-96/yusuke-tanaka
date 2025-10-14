output "domain_list_id" {
  description = "ID of the DNS Firewall domain list"
  value       = aws_route53_resolver_firewall_domain_list.this.id
}

output "rule_group_id" {
  description = "ID of the DNS Firewall rule group"
  value       = aws_route53_resolver_firewall_rule_group.this.id
}

output "rule_group_association_id" {
  description = "ID of the DNS Firewall rule group association"
  value       = aws_route53_resolver_firewall_rule_group_association.this.id
}

