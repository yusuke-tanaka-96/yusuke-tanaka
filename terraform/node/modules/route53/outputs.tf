# output "record_fqdn" {
#   value = aws_route53_record.this.fqdn
# }

output "zone_id" {
  description = "The ID of the hosted zone"
  value       = length(aws_route53_zone.this) > 0 ? aws_route53_zone.this[0].zone_id : var.zone_id

}

output "zone_name" {
  description = "The name of the hosted zone"
  value       = length(aws_route53_zone.this) > 0 ? aws_route53_zone.this[0].name : null
}

output "name_servers" {
  value = length(aws_route53_zone.this) > 0 ? aws_route53_zone.this[0].name_servers : null
}
