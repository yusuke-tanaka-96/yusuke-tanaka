# ssm-parameter module

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
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | List of ssm  parameters. | <pre>list(object({<br/>    name        = string<br/>    description = string<br/>    type        = string<br/>    value       = string<br/>    overwrite   = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the parameter. |
| <a name="output_name"></a> [name](#output\_name) | The name of the parameter. |
| <a name="output_version"></a> [version](#output\_version) | The version of the parameter. |
<!-- END_TF_DOCS -->
