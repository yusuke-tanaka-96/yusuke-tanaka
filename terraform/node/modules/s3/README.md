# s3 module

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
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.folder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_prefix"></a> [access\_log\_prefix](#input\_access\_log\_prefix) | Prefix for S3 access logs | `string` | `"S3AccessLogs/"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | S3 bucket policy | `string` | `""` | no |
| <a name="input_enable_object_lock"></a> [enable\_object\_lock](#input\_enable\_object\_lock) | Enable Object Lock for S3 bucket | `bool` | `false` | no |
| <a name="input_enable_partitioned_logging"></a> [enable\_partitioned\_logging](#input\_enable\_partitioned\_logging) | Enable partitioned prefix for S3 access logging | `bool` | `false` | no |
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | The name of the folder to create inside the S3 bucket. | `string` | `""` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle rules for S3 bucket | <pre>list(object({<br/>    id                        = string<br/>    status                    = string<br/>    prefix                    = string<br/>    expiration_days           = optional(number, null)<br/>    newer_noncurrent_versions = optional(number, null)<br/>    noncurrent_days           = optional(number, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Merged tags for resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming resources | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | suffix for naming resources | `string` | `""` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Object ownership controls for S3 bucket | `string` | `""` | no |
| <a name="input_replication_destination_bucket_arn"></a> [replication\_destination\_bucket\_arn](#input\_replication\_destination\_bucket\_arn) | ARN of the destination S3 bucket for replication | `string` | `null` | no |
| <a name="input_replication_role_arn"></a> [replication\_role\_arn](#input\_replication\_role\_arn) | IAM Role ARN for S3 Replication | `string` | `null` | no |
| <a name="input_replication_rules"></a> [replication\_rules](#input\_replication\_rules) | Replication rules for S3 bucket | <pre>list(object({<br/>    id          = string<br/>    prefix      = string<br/>    destination = string<br/>  }))</pre> | `[]` | no |
| <a name="input_replication_storage_class"></a> [replication\_storage\_class](#input\_replication\_storage\_class) | S3 storage class for replicated objects | `string` | `"STANDARD"` | no |
| <a name="input_server_access_logging"></a> [server\_access\_logging](#input\_server\_access\_logging) | Enable server access logging | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the S3 bucket | `map(string)` | `{}` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning for S3 bucket | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The domain name of the S3 bucket |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the S3 bucket |
<!-- END_TF_DOCS -->
