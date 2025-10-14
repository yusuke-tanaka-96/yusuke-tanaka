# systems_manager module

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
| [aws_ssm_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_document"></a> [create\_document](#input\_create\_document) | Whpf2er to create an SSM document | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the SSM parameter | `string` | `""` | no |
| <a name="input_document_content"></a> [document\_content](#input\_document\_content) | Content of the SSM document in YAML format | `string` | `""` | no |
| <a name="input_document_type"></a> [document\_type](#input\_document\_type) | Type of SSM document (e.g., Command, Policy, Automation) | `string` | `"Command"` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags to apply | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the parameter and document names (e.g., environment or project) | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix for the parameter and document names (e.g., purpose or service name) | `string` | `""` | no |
| <a name="input_parameter_type"></a> [parameter\_type](#input\_parameter\_type) | Type of SSM parameter (String, StringList, SecureString) | `string` | `"String"` | no |
| <a name="input_parameter_value"></a> [parameter\_value](#input\_parameter\_value) | Value of the SSM parameter | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_document_arn"></a> [document\_arn](#output\_document\_arn) | n/a |
| <a name="output_document_name"></a> [document\_name](#output\_document\_name) | n/a |
| <a name="output_parameter_arn"></a> [parameter\_arn](#output\_parameter\_arn) | n/a |
| <a name="output_parameter_name"></a> [parameter\_name](#output\_parameter\_name) | n/a |
<!-- END_TF_DOCS -->
