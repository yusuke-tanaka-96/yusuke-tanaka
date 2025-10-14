# network_firewall module

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
| [aws_networkfirewall_firewall.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall) | resource |
| [aws_networkfirewall_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy) | resource |
| [aws_networkfirewall_logging_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_logging_configuration) | resource |
| [aws_networkfirewall_rule_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the Network Firewall and Rule Group | `string` | `"Network Firewall managed by Terraform"` | no |
| <a name="input_destination_cidr"></a> [destination\_cidr](#input\_destination\_cidr) | Destination CIDR block for stateless rules | `string` | `"0.0.0.0/0"` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enable logging for the Network Firewall | `bool` | `false` | no |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | Log destination configuration (e.g., S3 bucket, CloudWatch Logs) | `map(string)` | `{}` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | Type of log destination (e.g., S3, CloudWatchLogs) | `string` | `"S3"` | no |
| <a name="input_log_type"></a> [log\_type](#input\_log\_type) | Type of logs to capture (e.g., ALERT, FLOW) | `string` | `"FLOW"` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix for resource names | `string` | n/a | yes |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | List of protocols for stateless rules (e.g., [6] for TCP) | `list(number)` | `[]` | no |
| <a name="input_rule_group_capacity"></a> [rule\_group\_capacity](#input\_rule\_group\_capacity) | Capacity of the rule group | `number` | `100` | no |
| <a name="input_rule_group_type"></a> [rule\_group\_type](#input\_rule\_group\_type) | Type of rule group (STATELESS or STATEFUL) | `string` | `"STATELESS"` | no |
| <a name="input_source_cidr"></a> [source\_cidr](#input\_source\_cidr) | Source CIDR block for stateless rules | `string` | `"0.0.0.0/0"` | no |
| <a name="input_stateful_rules"></a> [stateful\_rules](#input\_stateful\_rules) | List of stateful rules for the rule group | <pre>list(object({<br/>    action           = string<br/>    protocol         = number<br/>    source           = string<br/>    source_port      = string<br/>    direction        = string<br/>    destination      = string<br/>    destination_port = string<br/>    sid              = string<br/>  }))</pre> | `[]` | no |
| <a name="input_stateless_actions"></a> [stateless\_actions](#input\_stateless\_actions) | Actions for stateless rules | `list(string)` | <pre>[<br/>  "aws:pass"<br/>]</pre> | no |
| <a name="input_stateless_default_actions"></a> [stateless\_default\_actions](#input\_stateless\_default\_actions) | Default actions for stateless rules | `list(string)` | <pre>[<br/>  "aws:pass"<br/>]</pre> | no |
| <a name="input_stateless_fragment_default_actions"></a> [stateless\_fragment\_default\_actions](#input\_stateless\_fragment\_default\_actions) | Default actions for stateless fragment rules | `list(string)` | <pre>[<br/>  "aws:pass"<br/>]</pre> | no |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | List of subnet IDs for firewall endpoints | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the firewall will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_network_firewall"></a> [aws\_network\_firewall](#output\_aws\_network\_firewall) | Network Firewall resource |
| <a name="output_aws_network_firewall_policy_id"></a> [aws\_network\_firewall\_policy\_id](#output\_aws\_network\_firewall\_policy\_id) | ID of the DNS Firewall policy |
| <a name="output_firewall_arn"></a> [firewall\_arn](#output\_firewall\_arn) | ARN of the Network Firewall |
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | ID of the Network Firewall |
| <a name="output_firewall_policy_arn"></a> [firewall\_policy\_arn](#output\_firewall\_policy\_arn) | ARN of the Network Firewall Policy |
| <a name="output_rule_group_arn"></a> [rule\_group\_arn](#output\_rule\_group\_arn) | ARN of the Network Firewall Rule Group |
<!-- END_TF_DOCS -->
