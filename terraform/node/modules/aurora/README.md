# aurora module

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
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_rds_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.reader](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Number of days to retain backups | `number` | `7` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | Identifier for the Aurora cluster | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the initial database to be created | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Aurora PostgreSQL engine version | `string` | `"15.3"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class for Aurora instances | `string` | `"db.t4g.medium"` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Whpf2er to manage the master user password with AWS Secrets Manager | `bool` | `false` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Master username for the Aurora cluster | `string` | n/a | yes |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Tags to apply to all Aurora resources | `map(string)` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming resources | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix for naming resources | `string` | `""` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Whpf2er the DB instance is publicly accessible | `bool` | `false` | no |
| <a name="input_reader_count"></a> [reader\_count](#input\_reader\_count) | readerの追加 | `number` | `0` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to associate with Aurora cluster | `list(string)` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Whpf2er to skip final snapshot on deletion | `bool` | `true` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the Aurora DB subnet group | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID of the Aurora RDS Cluster |
| <a name="output_cluster_identifier"></a> [cluster\_identifier](#output\_cluster\_identifier) | cluster\_identifier of the Aurora Cluster |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | cluster\_identifier of the Aurora Cluster |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Writer endpoint of the Aurora RDS Cluster |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | ARN of the Aurora Cluster Instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Identifier of the Aurora Cluster Instance |
| <a name="output_rds_secret_arn"></a> [rds\_secret\_arn](#output\_rds\_secret\_arn) | ARN of the RDS master user secret |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | Reader endpoint of the Aurora RDS Cluster |
<!-- END_TF_DOCS -->
