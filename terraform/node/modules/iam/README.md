# iam module

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
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | List of assume IAM policies | <pre>list(object({<br/>    name    = string<br/>    content = string<br/>  }))</pre> | `[]` | no |
| <a name="input_aws_entities"></a> [aws\_entities](#input\_aws\_entities) | List of AWS principals (ARNs) for sts:AssumeRole | `list(string)` | `[]` | no |
| <a name="input_create_instance_profile"></a> [create\_instance\_profile](#input\_create\_instance\_profile) | Whpf2er to create an IAM instance profile | `bool` | `false` | no |
| <a name="input_federated_action"></a> [federated\_action](#input\_federated\_action) | action of Federated principals | `list(string)` | `[]` | no |
| <a name="input_federated_condition"></a> [federated\_condition](#input\_federated\_condition) | condition for Federated | `any` | `{}` | no |
| <a name="input_federated_entities"></a> [federated\_entities](#input\_federated\_entities) | List of federated principals for sts:AssumeRole | `list(string)` | `[]` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | List of inline IAM policies | <pre>list(object({<br/>    name    = string<br/>    content = string<br/>  }))</pre> | `[]` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Merged tags for resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming resources | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | suffix for naming resources | `string` | `""` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of AWS Managed Policy ARNs to attach | `list(string)` | `[]` | no |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | List of IAM policy statements | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the IAM Role | `string` | `null` | no |
| <a name="input_service_condition"></a> [service\_condition](#input\_service\_condition) | condition for sts:AssumeRole | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the IAM Role | `map(string)` | `{}` | no |
| <a name="input_trusted_entities"></a> [trusted\_entities](#input\_trusted\_entities) | Trusted entities for the IAM Role (e.g., s3.amazonaws.com, ec2.amazonaws.com) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_inline_policy_names"></a> [inline\_policy\_names](#output\_inline\_policy\_names) | Names of the inline policies |
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | The name of the instance profile |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the IAM Role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the IAM Role |
<!-- END_TF_DOCS -->
