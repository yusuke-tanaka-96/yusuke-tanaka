resource "aws_networkfirewall_rule_group" "this" {
  capacity    = var.rule_group_capacity
  name        = "${var.name_prefix}-${var.name_suffix}-rule-group"
  type        = var.rule_group_type
  description = var.description

  rule_group {
    rules_source {
      dynamic "stateless_rules_and_custom_actions" {
        for_each = var.rule_group_type == "STATELESS" ? [1] : []
        content {
          stateless_rule {
            rule_definition {
              match_attributes {
                source {
                  address_definition = var.source_cidr
                }
                destination {
                  address_definition = var.destination_cidr
                }
                protocols = var.protocols
              }
              actions = var.stateless_actions
            }
            priority = 100
          }
        }
      }
      dynamic "stateful_rule" {
        for_each = var.rule_group_type == "STATEFUL" ? var.stateful_rules : []
        content {
          action = stateful_rule.value.action
          header {
            protocol         = stateful_rule.value.protocol
            source           = stateful_rule.value.source
            source_port      = stateful_rule.value.source_port
            direction        = stateful_rule.value.direction
            destination      = stateful_rule.value.destination
            destination_port = stateful_rule.value.destination_port
          }
          rule_option {
            keyword = "sid:${stateful_rule.value.sid}"
          }
        }
      }
    }
  }

  tags = var.merged_tags
}

resource "aws_networkfirewall_firewall_policy" "this" {
  name = "${var.name_prefix}-${var.name_suffix}-policy"

  firewall_policy {
    stateless_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.this.arn
      priority     = 100
    }

    stateless_default_actions          = var.stateless_default_actions
    stateless_fragment_default_actions = var.stateless_fragment_default_actions
  }

  tags = var.merged_tags
}

resource "aws_networkfirewall_firewall" "this" {
  name        = "${var.name_prefix}-${var.name_suffix}"
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping
    content {
      subnet_id = subnet_mapping.value
    }
  }

  firewall_policy_arn = aws_networkfirewall_firewall_policy.this.arn

  tags = var.merged_tags
}

resource "aws_networkfirewall_logging_configuration" "this" {
  count = var.enable_logging ? 1 : 0

  firewall_arn = aws_networkfirewall_firewall.this.arn

  logging_configuration {
    log_destination_config {
      log_destination      = var.log_destination
      log_type             = var.log_type
      log_destination_type = var.log_destination_type
    }
  }
}