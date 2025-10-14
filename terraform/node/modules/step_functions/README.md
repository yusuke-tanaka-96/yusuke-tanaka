# step_functions module

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
| [aws_cloudwatch_log_group.sfn_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_sfn_state_machine.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_definition"></a> [definition](#input\_definition) | State machine definition in JSON | `string` | n/a | yes |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enable CloudWatch logging for Step Functions | `bool` | `true` | no |
| <a name="input_include_execution_data"></a> [include\_execution\_data](#input\_include\_execution\_data) | Include execution data in logs | `bool` | `true` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Logging level (ALL, ERROR, FATAL, OFF) | `string` | `"ALL"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | CloudWatch log retention in days | `number` | `7` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags to apply | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix for naming | `string` | `""` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | IAM Role ARN for Step Functions execution | `string` | n/a | yes |
| <a name="input_state_machine_type"></a> [state\_machine\_type](#input\_state\_machine\_type) | STANDARD or EXPRESS | `string` | `"STANDARD"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | n/a |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | n/a |
| <a name="output_state_machine_arn"></a> [state\_machine\_arn](#output\_state\_machine\_arn) | n/a |
| <a name="output_state_machine_name"></a> [state\_machine\_name](#output\_state\_machine\_name) | n/a |
<!-- END_TF_DOCS -->
