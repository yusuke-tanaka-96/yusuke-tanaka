resource "aws_dlm_lifecycle_policy" "ebs_backup_policy" {
  description        = "EBS Snapshot Life cycler Policy for Node"
  execution_role_arn = var.iam_role_arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]
    target_tags = merge(
      {
        synced = var.synced_tag_value
      },
      var.environment != null ? { environment = var.environment } : {}
    )
    schedule {
      name      = "${var.create_rule_interval}-${var.create_rule_interval_unit} Snapshots"
      copy_tags = true

      create_rule {
        interval      = var.create_rule_interval
        interval_unit = var.create_rule_interval_unit
        times         = ["00:00"]
      }

      retain_rule {
        interval      = var.retain_rule_interval
        interval_unit = var.retain_rule_interval_unit
      }
    }
  }

  tags = {
    Name = "${var.name_prefix}-dlm-policy-for-node"
  }
}
