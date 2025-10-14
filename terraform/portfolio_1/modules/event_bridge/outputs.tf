output "event_bus_name" {
  value = var.event_bus_name != "" ? aws_cloudwatch_event_bus.this[0].name : null
}

output "event_bus_arn" {
  value = var.event_bus_name != "" ? aws_cloudwatch_event_bus.this[0].arn : null
}
