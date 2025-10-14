# data_lifecycle_manager module

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
| [aws_dlm_lifecycle_policy.ebs_backup_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_rule_interval"></a> [create\_rule\_interval](#input\_create\_rule\_interval) | The interval of create rule. | `number` | n/a | yes |
| <a name="input_create_rule_interval_unit"></a> [create\_rule\_interval\_unit](#input\_create\_rule\_interval\_unit) | The interval unit of create rule. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN of the IAM role to use for the DLM policy. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_retain_rule_interval"></a> [retain\_rule\_interval](#input\_retain\_rule\_interval) | The interval of the retain rule. | `number` | n/a | yes |
| <a name="input_retain_rule_interval_unit"></a> [retain\_rule\_interval\_unit](#input\_retain\_rule\_interval\_unit) | The interval unit of retain rule. | `string` | n/a | yes |
| <a name="input_synced_tag_value"></a> [synced\_tag\_value](#input\_synced\_tag\_value) | The value of the tag to identify the EBS volumes for backup. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
