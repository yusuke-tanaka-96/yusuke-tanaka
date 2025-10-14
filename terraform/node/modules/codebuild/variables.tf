variable "projects" {
  type = list(object({
    name               = string
    build_timeout      = number
    queued_timeout     = number
    service_role       = string
    encryption_key     = string
    source_version     = string
    project_visibility = string
    badge_enabled      = bool

    artifacts = object({
      type                   = string
      encryption_disabled    = bool
      override_artifact_name = bool
    })

    cache = object({
      type  = string
      modes = list(string)
    })

    environment = object({
      compute_type                = string
      image                       = string
      type                        = string
      privileged_mode             = bool
      image_pull_credentials_type = string
      environment_variables = list(object({
        name  = string
        type  = string
        value = string
      }))
    })

    logs_config = object({
      cloudwatch_logs = object({
        status            = string
        retention_in_days = optional(number)
      })
      s3_logs = object({
        status              = string
        encryption_disabled = bool
      })
    })

    source = object({
      type                = string
      location            = string
      buildspec           = string
      git_clone_depth     = number
      insecure_ssl        = bool
      report_build_status = bool
      git_submodules_config = object({
        fetch_submodules = bool
      })
    })

    // Optional VPC configuration for the CodeBuild project
    vpc_config = optional(object({
      vpc_id             = string
      subnets            = list(string)
      security_group_ids = list(string)
    }))

    tags = optional(map(string))
  }))
}
