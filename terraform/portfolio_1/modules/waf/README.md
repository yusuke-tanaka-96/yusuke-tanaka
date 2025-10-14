# waf module

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
| [aws_wafv2_ip_set.whitelist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associate_arn"></a> [associate\_arn](#input\_associate\_arn) | ARN of resource to associate (e.g. ALB, API Gateway) | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | WAF description | `string` | `"WAF Web ACL managed by Terraform"` | no |
| <a name="input_enable_association"></a> [enable\_association](#input\_enable\_association) | Whpf2er to associate the WAF with a resource | `bool` | `false` | no |
| <a name="input_enable_managed_rule"></a> [enable\_managed\_rule](#input\_enable\_managed\_rule) | Enable AWSManagedRulesCommonRuleSet | `bool` | `true` | no |
| <a name="input_enable_rate_limit"></a> [enable\_rate\_limit](#input\_enable\_rate\_limit) | Enable rate limit rule | `bool` | `true` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Tags to apply | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for WAF resource name | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix for WAF resource name | `string` | n/a | yes |
| <a name="input_rate_limit"></a> [rate\_limit](#input\_rate\_limit) | Rate limit per 5 minutes per IP | `number` | `2000` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope: REGIONAL (ALB/API GW) or CLOUDFRONT | `string` | `"REGIONAL"` | no |
| <a name="input_whitelist_ips"></a> [whitelist\_ips](#input\_whitelist\_ips) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | n/a |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | n/a |
<!-- END_TF_DOCS -->
