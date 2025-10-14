resource "aws_wafv2_web_acl" "this" {
  name        = "${var.name_prefix}-${var.name_suffix}"
  description = var.description
  scope       = var.scope

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name_prefix}-${var.name_suffix}"
    sampled_requests_enabled   = true
  }

  # AWS Managed Rules
  dynamic "rule" {
    for_each = var.enable_managed_rule ? [
      {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
        priority    = 1
      },
      {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
        priority    = 2
      },
      {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
        priority    = 3
      }
    ] : []

    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = rule.value.vendor_name
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  # Rate limit
  dynamic "rule" {
    for_each = var.enable_rate_limit ? [1] : []
    content {
      name     = "RateLimitRule"
      priority = 4
      action {
        block {}
      }

      statement {
        rate_based_statement {
          limit              = var.rate_limit
          aggregate_key_type = "IP"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "RateLimitRule"
        sampled_requests_enabled   = true
      }
    }
  }

  rule {
    name     = "AllowWhitelistIPs"
    priority = 5
    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.whitelist.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AllowWhitelistIPs"
      sampled_requests_enabled   = true
    }
  }

  # Custom rules from variable
  dynamic "rule" {
    for_each = { for rule in var.custom_rules : rule.name => rule }
    content {
      name     = rule.value.name
      priority = rule.value.priority

      action {
        dynamic "allow" {
          for_each = rule.value.default_action == "allow" ? [1] : []
          content {}
        }
        dynamic "block" {
          for_each = rule.value.default_action == "block" ? [1] : []
          content {}
        }
      }

      statement {
        byte_match_statement {
          field_to_match {
            uri_path {}
          }
          positional_constraint = "STARTS_WITH"
          search_string         = rule.value.path_starts_with
          text_transformation {
            priority = 0
            type     = "NONE"
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  lifecycle {
    ignore_changes = [rule]
  }

  tags = var.merged_tags
}

resource "aws_wafv2_web_acl_association" "this" {
  count        = var.enable_association ? 1 : 0
  resource_arn = var.associate_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}

resource "aws_wafv2_ip_set" "whitelist" {
  name               = "${var.name_prefix}-${var.name_suffix}-whitelist"
  description        = "Temporary whitelist IPs for security test"
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.whitelist_ips
  tags               = var.merged_tags
}
