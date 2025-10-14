# dns_firewall module

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
| [aws_route53_resolver_firewall_domain_list.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_domain_list) | resource |
| [aws_route53_resolver_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule) | resource |
| [aws_route53_resolver_firewall_rule_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule_group) | resource |
| [aws_route53_resolver_firewall_rule_group_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_firewall_rule_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_priority"></a> [association\_priority](#input\_association\_priority) | Priority for the firewall rule group association | `number` | `100` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | List of domains for the DNS Firewall domain list | `list(string)` | `[]` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of DNS Firewall rules | <pre>list(object({<br/>    action                = string<br/>    priority              = number<br/>    block_response        = string<br/>    block_override_domain = string<br/>    block_override_ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix for resource names | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC to associate with the DNS Firewall | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_list_id"></a> [domain\_list\_id](#output\_domain\_list\_id) | ID of the DNS Firewall domain list |
| <a name="output_rule_group_association_id"></a> [rule\_group\_association\_id](#output\_rule\_group\_association\_id) | ID of the DNS Firewall rule group association |
| <a name="output_rule_group_id"></a> [rule\_group\_id](#output\_rule\_group\_id) | ID of the DNS Firewall rule group |
<!-- END_TF_DOCS -->
