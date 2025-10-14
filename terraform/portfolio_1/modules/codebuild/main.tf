resource "aws_cloudwatch_log_group" "this" {
  for_each = { for pj in var.projects : pj.name => pj if lookup(pj.logs_config.cloudwatch_logs, "status", "DISABLED") == "ENABLED" }

  name              = "/aws/codebuild/${each.value.name}"
  retention_in_days = try(each.value.logs_config.cloudwatch_logs.retention_in_days, 0)

  tags = try(each.value.tags, {})
}

resource "aws_codebuild_project" "this" {
  for_each = { for pj in var.projects : pj.name => pj }

  name               = each.value.name
  build_timeout      = each.value.build_timeout
  queued_timeout     = each.value.queued_timeout
  service_role       = each.value.service_role
  encryption_key     = each.value.encryption_key
  source_version     = each.value.source_version
  project_visibility = each.value.project_visibility
  badge_enabled      = each.value.badge_enabled

  artifacts {
    type                   = each.value.artifacts.type
    encryption_disabled    = each.value.artifacts.encryption_disabled
    override_artifact_name = each.value.artifacts.override_artifact_name
  }

  cache {
    type  = each.value.cache.type
    modes = try(each.value.cache.modes, [])
  }

  environment {
    compute_type                = each.value.environment.compute_type
    image                       = each.value.environment.image
    type                        = each.value.environment.type
    privileged_mode             = each.value.environment.privileged_mode
    image_pull_credentials_type = each.value.environment.image_pull_credentials_type

    dynamic "environment_variable" {
      for_each = each.value.environment.environment_variables
      content {
        name  = environment_variable.value.name
        type  = environment_variable.value.type
        value = environment_variable.value.value
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      status = each.value.logs_config.cloudwatch_logs.status
    }
    s3_logs {
      status              = each.value.logs_config.s3_logs.status
      encryption_disabled = each.value.logs_config.s3_logs.encryption_disabled
    }
  }

  source {
    type                = each.value.source.type
    location            = each.value.source.location
    buildspec           = each.value.source.buildspec
    git_clone_depth     = each.value.source.git_clone_depth
    insecure_ssl        = each.value.source.insecure_ssl
    report_build_status = each.value.source.report_build_status

    git_submodules_config {
      fetch_submodules = each.value.source.git_submodules_config.fetch_submodules
    }
  }

  dynamic "vpc_config" {
    for_each = lookup(each.value, "vpc_config", null) != null ? [each.value.vpc_config] : []
    content {
      vpc_id             = vpc_config.value.vpc_id
      subnets            = vpc_config.value.subnets
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  lifecycle {
    ignore_changes = [
      source[0].git_clone_depth,
      source[0].git_submodules_config,
    ]
  }

  tags = try(each.value.tags, {})

  depends_on = [
    aws_cloudwatch_log_group.this
  ]

}
