# inspector module

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
| [aws_inspector2_enabler.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_enabler) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | AWS account ID | `string` | n/a | yes |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names | `string` | n/a | yes |
| <a name="input_resource_types"></a> [resource\_types](#input\_resource\_types) | Inspector resource types to scan | `list(string)` | <pre>[<br/>  "EC2",<br/>  "ECR",<br/>  "LAMBDA"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_inspector_enabled_account_ids"></a> [inspector\_enabled\_account\_ids](#output\_inspector\_enabled\_account\_ids) | Account IDs enabled for Inspector |
<!-- END_TF_DOCS -->
