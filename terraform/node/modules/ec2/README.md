# ec2 module

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
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.blue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.green](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_capacity_factor"></a> [active\_capacity\_factor](#input\_active\_capacity\_factor) | Active capacity factor for the Auto Scaling Group | `number` | `2` | no |
| <a name="input_additional_volume_size"></a> [additional\_volume\_size](#input\_additional\_volume\_size) | size of additional volume | `number` | `20` | no |
| <a name="input_additional_volume_type"></a> [additional\_volume\_type](#input\_additional\_volume\_type) | type of additional volume | `string` | `"gp3"` | no |
| <a name="input_alb_ip_address_type"></a> [alb\_ip\_address\_type](#input\_alb\_ip\_address\_type) | IP address type for the ALB (ipv4 or dualstack) | `string` | `"ipv4"` | no |
| <a name="input_alb_scheme"></a> [alb\_scheme](#input\_alb\_scheme) | ALB scheme, 'internet-facing' or 'internal' | `string` | `"internal"` | no |
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | List of subnet IDs to alb | `list(string)` | `[]` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID to use for the instance | `string` | `""` | no |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | auto scaling group name | `string` | `""` | no |
| <a name="input_asg_subnet_ids"></a> [asg\_subnet\_ids](#input\_asg\_subnet\_ids) | List of subnet IDs for Auto Scaling Group | `list(string)` | `[]` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whpf2er to associate a public IP address | `bool` | `false` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | arn of certificate | `string` | `""` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of instances in the Auto Scaling Group | `number` | `null` | no |
| <a name="input_ec2_subnet_id"></a> [ec2\_subnet\_id](#input\_ec2\_subnet\_id) | Subnet ID where the instance will be deployed | `string` | `""` | no |
| <a name="input_enable_alb"></a> [enable\_alb](#input\_enable\_alb) | Whpf2er to create Application Load Balancer | `bool` | `false` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Whpf2er to create Auto Scaling Group | `bool` | `false` | no |
| <a name="input_enable_ec2"></a> [enable\_ec2](#input\_enable\_ec2) | Whpf2er to create ec2 instance | `bool` | `false` | no |
| <a name="input_enable_elb"></a> [enable\_elb](#input\_enable\_elb) | Whpf2er to create Network Load Balancer | `bool` | `false` | no |
| <a name="input_enable_launch_template"></a> [enable\_launch\_template](#input\_enable\_launch\_template) | Whpf2er to create Launch Template | `bool` | `false` | no |
| <a name="input_enable_test_listener"></a> [enable\_test\_listener](#input\_enable\_test\_listener) | テスト用リスナーを有効にするか。 | `bool` | `false` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | ターゲットグループの健全な閾値。 | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | ターゲットグループのヘルスチェック間隔 (秒)。 | `number` | `30` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | ターゲットグループのヘルスチェックHTTPコード。 | `string` | `"200"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | ターゲットグループのヘルスチェックパス。 | `string` | `"/"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | ターゲットグループのヘルスチェックプロトコル。 | `string` | `"HTTP"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | ターゲットグループのヘルスチェックタイムアウト (秒)。 | `number` | `5` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | ターゲットグループの異常な閾値。 | `number` | `2` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | IAM instance profile name to attach | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the EC2 instance | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name of the Key Pair | `string` | `null` | no |
| <a name="input_lb_idle_timeout"></a> [lb\_idle\_timeout](#input\_lb\_idle\_timeout) | Idle timeout for the ALB | `number` | `60` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | name of load blancer | `string` | `""` | no |
| <a name="input_lb_tg_name"></a> [lb\_tg\_name](#input\_lb\_tg\_name) | target group name of load blancer | `string` | `""` | no |
| <a name="input_lifecycle_hook_heartbeat_timeout"></a> [lifecycle\_hook\_heartbeat\_timeout](#input\_lifecycle\_hook\_heartbeat\_timeout) | Heartbeat timeout for the lifecycle hook | `number` | `null` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Type of load balancer | `string` | `""` | no |
| <a name="input_lt_name"></a> [lt\_name](#input\_lt\_name) | name of launch template | `string` | `""` | no |
| <a name="input_main_listener_port"></a> [main\_listener\_port](#input\_main\_listener\_port) | メインリスナーのポート。 | `number` | `80` | no |
| <a name="input_max_healthy_percentage"></a> [max\_healthy\_percentage](#input\_max\_healthy\_percentage) | max healthy percentage for ASG | `number` | `"200"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of instances in the Auto Scaling Group | `number` | `null` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Merged tags for resources | `map(string)` | `{}` | no |
| <a name="input_min_healthy_percentage"></a> [min\_healthy\_percentage](#input\_min\_healthy\_percentage) | min healthy percentage for ASG | `number` | `"100"` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of instances in the Auto Scaling Group | `number` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming resources | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | suffix for naming resources | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | port of load balancer | `string` | `"80"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | protocol of load balancer | `string` | `"HTTP"` | no |
| <a name="input_refresh_buffer_factor"></a> [refresh\_buffer\_factor](#input\_refresh\_buffer\_factor) | Refresh buffer factor for the Auto Scaling Group | `number` | `2` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of the root volume in GB | `number` | `8` | no |
| <a name="input_security_group_ids_ec2"></a> [security\_group\_ids\_ec2](#input\_security\_group\_ids\_ec2) | List of security group IDs to associate with | `list(string)` | `[]` | no |
| <a name="input_security_group_ids_lb"></a> [security\_group\_ids\_lb](#input\_security\_group\_ids\_lb) | List of security group IDs to associate with | `list(string)` | `[]` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | policy of ssl | `string` | `""` | no |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | port of target group | `string` | `"80"` | no |
| <a name="input_target_protocol"></a> [target\_protocol](#input\_target\_protocol) | target\_protocol of load balancer | `string` | `null` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | target\_type of load balancer | `string` | `"instance"` | no |
| <a name="input_test_listener_port"></a> [test\_listener\_port](#input\_test\_listener\_port) | テスト用リスナーのポート。 | `number` | `280` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to run at launch | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc\_id of load balancer | `string` | `""` | no |
| <a name="input_warm_pool_max_group_prepared_capacity"></a> [warm\_pool\_max\_group\_prepared\_capacity](#input\_warm\_pool\_max\_group\_prepared\_capacity) | Maximum number of instances in the warm pool | `number` | `0` | no |
| <a name="input_warm_pool_min_size"></a> [warm\_pool\_min\_size](#input\_warm\_pool\_min\_size) | Minimum number of instances in the warm pool | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN of the Auto Scaling Group. |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The name of the Auto Scaling Group. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The ARN of the EC2 instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the EC2 instance |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | ID of the created Launch Template |
| <a name="output_launch_template_name"></a> [launch\_template\_name](#output\_launch\_template\_name) | The name of the Launch Template. |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The ARN of the Load Balancer. |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS name of the Load Balancer. |
| <a name="output_lb_listener_main_arn"></a> [lb\_listener\_main\_arn](#output\_lb\_listener\_main\_arn) | メインのロードバランサーリスナーのARN。 |
| <a name="output_lb_listener_test_arn"></a> [lb\_listener\_test\_arn](#output\_lb\_listener\_test\_arn) | テスト用のロードバランサーリスナーのARN (オプション)。 |
| <a name="output_lb_target_group_arn_blue"></a> [lb\_target\_group\_arn\_blue](#output\_lb\_target\_group\_arn\_blue) | BlueターゲットグループのARN。 |
| <a name="output_lb_target_group_arn_green"></a> [lb\_target\_group\_arn\_green](#output\_lb\_target\_group\_arn\_green) | GreenターゲットグループのARN。 |
| <a name="output_lb_target_group_name_blue"></a> [lb\_target\_group\_name\_blue](#output\_lb\_target\_group\_name\_blue) | Blueターゲットグループの名前。 |
| <a name="output_lb_target_group_name_green"></a> [lb\_target\_group\_name\_green](#output\_lb\_target\_group\_name\_green) | Greenターゲットグループの名前。 |
| <a name="output_lb_zone_id"></a> [lb\_zone\_id](#output\_lb\_zone\_id) | The Zone ID of the Load Balancer. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address of the EC2 instance |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address assigned to the EC2 instance |
<!-- END_TF_DOCS -->
