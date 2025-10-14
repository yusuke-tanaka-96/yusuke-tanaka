# lambda module

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
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | value | `list(string)` | <pre>[<br/>  "x86_64"<br/>]</pre> | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | environment variables | `list(object({ name = string, value = string }))` | `[]` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Lambda function name | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda function handler | `string` | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | IAM role ARN for Lambda | `string` | n/a | yes |
| <a name="input_local_zip_path"></a> [local\_zip\_path](#input\_local\_zip\_path) | Path to the local ZIP file for Lambda deployment. If specified, S3 arguments are ignored. | `string` | `""` | no |
| <a name="input_log_group"></a> [log\_group](#input\_log\_group) | name of log group | `string` | `""` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory size for the Lambda function | `number` | `128` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Merged tags for resources | `map(string)` | `{}` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | package type | `string` | `"Zip"` | no |
| <a name="input_phemeral_storage_size"></a> [phemeral\_storage\_size](#input\_phemeral\_storage\_size) | size of phemeral storage | `number` | `512` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | reserved concurrent executions | `string` | `"-1"` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtime environment for the Lambda function | `string` | n/a | yes |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket containing the Lambda source code | `string` | `""` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | S3 key (object path) of the Lambda zip file | `string` | `""` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | S3 object version (optional) | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | list of security group ids | `list(string)` | `[]` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | skip destroy | `string` | `"false"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | list of subnet ids | `list(string)` | `[]` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout for the Lambda function | `number` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda function |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda function |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | The latest published version of the Lambda function |
<!-- END_TF_DOCS -->
