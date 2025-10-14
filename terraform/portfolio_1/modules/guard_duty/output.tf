output "detector_id" {
  description = "ID of the GuardDuty detector"
  value       = aws_guardduty_detector.this.id
}

# Temporarily commented out due to resource being disabled
# output "publishing_destination_id" {
#   description = "ID of the GuardDuty publishing destination (if enabled)"
#   value       = var.enable_publishing_destination ? aws_guardduty_publishing_destination.this[0].id : null
# }