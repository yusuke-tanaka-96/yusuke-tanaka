# security_hub module

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
| [aws_securityhub_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_finding_aggregator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_finding_aggregator) | resource |
| [aws_securityhub_standards_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator_linking_mode"></a> [aggregator\_linking\_mode](#input\_aggregator\_linking\_mode) | Linking mode for finding aggregator (ALL\_REGIONS or SPECIFIED\_REGIONS) | `string` | `"ALL_REGIONS"` | no |
| <a name="input_aggregator_regions"></a> [aggregator\_regions](#input\_aggregator\_regions) | List of regions for finding aggregator when linking\_mode is SPECIFIED\_REGIONS | `list(string)` | `[]` | no |
| <a name="input_auto_enable_controls"></a> [auto\_enable\_controls](#input\_auto\_enable\_controls) | Whpf2er to automatically enable new controls | `bool` | `true` | no |
| <a name="input_control_finding_generator"></a> [control\_finding\_generator](#input\_control\_finding\_generator) | Which controls generate findings (SECURITY\_CONTROL or STANDARD\_CONTROL) | `string` | `"SECURITY_CONTROL"` | no |
| <a name="input_enable_default_standards"></a> [enable\_default\_standards](#input\_enable\_default\_standards) | Whpf2er to enable the default standards for Security Hub | `bool` | `true` | no |
| <a name="input_enable_finding_aggregator"></a> [enable\_finding\_aggregator](#input\_enable\_finding\_aggregator) | Whpf2er to enable finding aggregator for multi-region aggregation | `bool` | `false` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags to apply to Security Hub resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (e.g., environment or project) | `string` | n/a | yes |
| <a name="input_standards_arns"></a> [standards\_arns](#input\_standards\_arns) | List of Security Hub standards ARNs to enable | `list(string)` | <pre>[<br/>  "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0",<br/>  "arn:aws:securityhub:::ruleset/aws-foundational-security-best-practices/v/1.0.0"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_finding_aggregator_id"></a> [finding\_aggregator\_id](#output\_finding\_aggregator\_id) | ID of the Security Hub finding aggregator (if enabled) |
| <a name="output_securityhub_account_id"></a> [securityhub\_account\_id](#output\_securityhub\_account\_id) | ID of the Security Hub account |
| <a name="output_standards_subscription_arns"></a> [standards\_subscription\_arns](#output\_standards\_subscription\_arns) | List of ARNs for subscribed Security Hub standards |
<!-- END_TF_DOCS -->
