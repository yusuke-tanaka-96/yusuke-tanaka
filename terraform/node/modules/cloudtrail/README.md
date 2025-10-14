# cloudtrail module

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
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#input\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch Log Group for CloudTrail logs | `string` | `""` | no |
| <a name="input_cloudwatch_role_arn"></a> [cloudwatch\_role\_arn](#input\_cloudwatch\_role\_arn) | ARN of the IAM role for CloudWatch Logs integration | `string` | `""` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Whpf2er to enable log file validation for CloudTrail | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Whpf2er to enable logging for CloudTrail | `bool` | `true` | no |
| <a name="input_event_selector_read_write_type"></a> [event\_selector\_read\_write\_type](#input\_event\_selector\_read\_write\_type) | Read/write type for CloudTrail event selector (All, ReadOnly, WriteOnly) | `string` | `"All"` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | Whpf2er to include global service events in CloudTrail | `bool` | `true` | no |
| <a name="input_include_management_events"></a> [include\_management\_events](#input\_include\_management\_events) | Whpf2er to include management events in the event selector | `bool` | `true` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | Whpf2er the trail is multi-regiaon | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Optional KMS key ID for CloudTrail log encryption | `string` | `""` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags to apply to the CloudTrail trail | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the CloudTrail trail name (e.g., environment or project) | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the existing S3 bucket for CloudTrail logs | `string` | n/a | yes |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | Prefix for the S3 bucket for CloudTrail logs | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_trail_arn"></a> [trail\_arn](#output\_trail\_arn) | ARN of the CloudTrail trail |
| <a name="output_trail_name"></a> [trail\_name](#output\_trail\_name) | Name of the CloudTrail trail |
<!-- END_TF_DOCS -->
