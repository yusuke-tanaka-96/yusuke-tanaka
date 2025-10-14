# codebuild module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_projects"></a> [projects](#input\_projects) | n/a | <pre>list(object({<br/>    name               = string<br/>    build_timeout      = number<br/>    queued_timeout     = number<br/>    service_role       = string<br/>    encryption_key     = string<br/>    source_version     = string<br/>    project_visibility = string<br/>    badge_enabled      = bool<br/><br/>    artifacts = object({<br/>      type                   = string<br/>      encryption_disabled    = bool<br/>      override_artifact_name = bool<br/>    })<br/><br/>    cache = object({<br/>      type  = string<br/>      modes = list(string)<br/>    })<br/><br/>    environment = object({<br/>      compute_type                = string<br/>      image                       = string<br/>      type                        = string<br/>      privileged_mode             = bool<br/>      image_pull_credentials_type = string<br/>      environment_variables = list(object({<br/>        name  = string<br/>        type  = string<br/>        value = string<br/>      }))<br/>    })<br/><br/>    logs_config = object({<br/>      cloudwatch_logs = object({<br/>        status = string<br/>      })<br/>      s3_logs = object({<br/>        status              = string<br/>        encryption_disabled = bool<br/>      })<br/>    })<br/><br/>    source = object({<br/>      type                = string<br/>      location            = string<br/>      buildspec           = string<br/>      git_clone_depth     = number<br/>      insecure_ssl        = bool<br/>      report_build_status = bool<br/>      git_submodules_config = object({<br/>        fetch_submodules = bool<br/>      })<br/>    })<br/><br/>    tags = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_arns"></a> [project\_arns](#output\_project\_arns) | n/a |
| <a name="output_project_names"></a> [project\_names](#output\_project\_names) | n/a |
<!-- END_TF_DOCS -->
