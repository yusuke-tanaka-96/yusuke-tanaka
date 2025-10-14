# codepipeline module

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
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pipelines"></a> [pipelines](#input\_pipelines) | List of CodePipeline definitions | <pre>list(object({<br/>    name           = string<br/>    role_arn       = string<br/>    pipeline_type  = string<br/>    execution_mode = string<br/>    artifact_store = object({<br/>      type     = string<br/>      location = string<br/>    })<br/>    stages = list(object({<br/>      name = string<br/>      actions = list(object({<br/>        name             = string<br/>        category         = string<br/>        owner            = string<br/>        provider         = string<br/>        version          = string<br/>        region           = string<br/>        run_order        = number<br/>        namespace        = optional(string)<br/>        output_artifacts = optional(list(string))<br/>        input_artifacts  = optional(list(string))<br/>        configuration    = map(string)<br/>      }))<br/>      on_failure = optional(object({<br/>        result = string<br/>        retry_configuration = optional(object({<br/>          retry_mode = string<br/>        }))<br/>      }))<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipeline_arns"></a> [pipeline\_arns](#output\_pipeline\_arns) | n/a |
| <a name="output_pipeline_names"></a> [pipeline\_names](#output\_pipeline\_names) | n/a |
<!-- END_TF_DOCS -->
