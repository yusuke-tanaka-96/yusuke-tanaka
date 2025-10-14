output "firewall_arn" {
  description = "ARN of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.arn
}

output "firewall_policy_arn" {
  description = "ARN of the Network Firewall Policy"
  value       = aws_networkfirewall_firewall_policy.this.arn
}

output "rule_group_arn" {
  description = "ARN of the Network Firewall Rule Group"
  value       = aws_networkfirewall_rule_group.this.arn
}

output "firewall_id" {
  description = "ID of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.id
}

output "aws_network_firewall_policy_id" {
  description = "ID of the DNS Firewall policy"
  value       = aws_networkfirewall_firewall_policy.this.id
}

output "aws_network_firewall" {
  description = "Network Firewall resource"
  value       = aws_networkfirewall_firewall.this
}