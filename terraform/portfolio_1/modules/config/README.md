# config module

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
| [aws_config_configuration_recorder.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_supported"></a> [all\_supported](#input\_all\_supported) | Whpf2er to record all supported resource types | `bool` | `true` | no |
| <a name="input_config_role_arn"></a> [config\_role\_arn](#input\_config\_role\_arn) | ARN of the IAM role for AWS Config | `string` | n/a | yes |
| <a name="input_enable_recording"></a> [enable\_recording](#input\_enable\_recording) | Whpf2er to enable AWS Config recording | `bool` | `true` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | ARN of the IAM role for AWS Config | `string` | `""` | no |
| <a name="input_include_global_resource_types"></a> [include\_global\_resource\_types](#input\_include\_global\_resource\_types) | Whpf2er to include global resource types (e.g., IAM) | `bool` | `true` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags to apply to AWS Config resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the AWS Config resource names (e.g., environment or project) | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the existing S3 bucket for AWS Config logs | `string` | n/a | yes |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | Optional S3 key prefix for AWS Config logs | `string` | `"AWSConfig"` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | Optional ARN of the SNS topic for AWS Config notifications | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_recorder_arn"></a> [config\_recorder\_arn](#output\_config\_recorder\_arn) | ARN of the AWS Config recorder |
| <a name="output_config_recorder_name"></a> [config\_recorder\_name](#output\_config\_recorder\_name) | Name of the AWS Config recorder |
| <a name="output_delivery_channel_name"></a> [delivery\_channel\_name](#output\_delivery\_channel\_name) | Name of the AWS Config delivery channel |
<!-- END_TF_DOCS -->
