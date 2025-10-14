# codedeploy module

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
| [aws_codedeploy_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_deployment_groups"></a> [deployment\_groups](#input\_deployment\_groups) | n/a | <pre>list(object({<br/>    deployment_group_name = string<br/>    cluster_name          = string<br/>    service_name          = string<br/>    listener_arns         = list(string)<br/>    target_group_blue     = string<br/>    target_group_green    = string<br/>  }))</pre> | n/a | yes |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | n/a |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | n/a |
| <a name="output_deployment_group_ids"></a> [deployment\_group\_ids](#output\_deployment\_group\_ids) | n/a |
| <a name="output_deployment_group_names"></a> [deployment\_group\_names](#output\_deployment\_group\_names) | n/a |
<!-- END_TF_DOCS -->
