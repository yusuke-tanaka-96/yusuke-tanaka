# ecs module

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
| [aws_appautoscaling_policy.cpu_target_tracking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.task_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | パブリックIP割り当て（true = ENABLED） | `bool` | `false` | no |
| <a name="input_autoscaling_cpu_target_value"></a> [autoscaling\_cpu\_target\_value](#input\_autoscaling\_cpu\_target\_value) | CPU使用率のターゲット値（%） | `number` | `70` | no |
| <a name="input_autoscaling_max"></a> [autoscaling\_max](#input\_autoscaling\_max) | サービスのオートスケーリング最大数 | `number` | `3` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | 最大タスク数 | `number` | `5` | no |
| <a name="input_autoscaling_min"></a> [autoscaling\_min](#input\_autoscaling\_min) | サービスのオートスケーリング最小数 | `number` | `1` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | 最小タスク数 | `number` | `0` | no |
| <a name="input_autoscaling_scale_in_cooldown"></a> [autoscaling\_scale\_in\_cooldown](#input\_autoscaling\_scale\_in\_cooldown) | スケールインのクールダウン時間（秒） | `number` | `300` | no |
| <a name="input_autoscaling_scale_out_cooldown"></a> [autoscaling\_scale\_out\_cooldown](#input\_autoscaling\_scale\_out\_cooldown) | スケールアウトのクールダウン時間（秒） | `number` | `300` | no |
| <a name="input_blue_green_deployment_ready_action_on_timeout"></a> [blue\_green\_deployment\_ready\_action\_on\_timeout](#input\_blue\_green\_deployment\_ready\_action\_on\_timeout) | デプロイ承認タイムアウト時の動作 ('CONTINUE\_DEPLOYMENT', 'STOP\_DEPLOYMENT'). | `string` | `"CONTINUE_DEPLOYMENT"` | no |
| <a name="input_blue_green_deployment_ready_wait_time_in_minutes"></a> [blue\_green\_deployment\_ready\_wait\_time\_in\_minutes](#input\_blue\_green\_deployment\_ready\_wait\_time\_in\_minutes) | デプロイ承認待機時間 (分)。手動承認を使用しない場合は 0。 | `number` | `0` | no |
| <a name="input_blue_green_terminate_action"></a> [blue\_green\_terminate\_action](#input\_blue\_green\_terminate\_action) | 成功時に古いインスタンスを終了する方法 ('TERMINATE', 'RETAIN'). | `string` | `"TERMINATE"` | no |
| <a name="input_blue_green_terminate_wait_time_in_minutes"></a> [blue\_green\_terminate\_wait\_time\_in\_minutes](#input\_blue\_green\_terminate\_wait\_time\_in\_minutes) | 古いインスタンス終了までの待機時間 (分)。 | `number` | `5` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | ECSクラスターID | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | ECSクラスター名 | `string` | `""` | no |
| <a name="input_codedeploy_service_role_arn"></a> [codedeploy\_service\_role\_arn](#input\_codedeploy\_service\_role\_arn) | AWS CodeDeployがサービスにアクセスするためのIAMロールのARN。enable\_blue\_green\_deployment が true の場合は必須。 | `string` | `null` | no |
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | Command to run inside the container | `list(string)` | `[]` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | container cpu | `number` | `512` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | tcontainer image | `string` | `""` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | ロードバランサに対応するコンテナ名 | `string` | `""` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | コンテナポート番号 | `number` | `80` | no |
| <a name="input_cpu_target_value"></a> [cpu\_target\_value](#input\_cpu\_target\_value) | ターゲットとなるCPU使用率（%） | `number` | `50` | no |
| <a name="input_deployment_max_percent"></a> [deployment\_max\_percent](#input\_deployment\_max\_percent) | 最大稼働タスク数（%） | `number` | `200` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | デプロイ中にRunningステータスにあるタスクの最大パーセンテージ。CodeDeployまたはECSサービスが管理します。 | `number` | `200` | no |
| <a name="input_deployment_min_percent"></a> [deployment\_min\_percent](#input\_deployment\_min\_percent) | 最小稼働タスク数（%） | `number` | `100` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | デプロイ中にRunningステータスにあるタスクの最小パーセンテージ。CodeDeployまたはECSサービスが管理します。 | `number` | `100` | no |
| <a name="input_desired_task_count"></a> [desired\_task\_count](#input\_desired\_task\_count) | 必要なタスク数 | `number` | `1` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | ECSクラスターID | `string` | `""` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | ecs service name | `string` | `""` | no |
| <a name="input_ecs_task_name"></a> [ecs\_task\_name](#input\_ecs\_task\_name) | ecs task name | `string` | `""` | no |
| <a name="input_enable_blue_green_deployment"></a> [enable\_blue\_green\_deployment](#input\_enable\_blue\_green\_deployment) | Blue/Green デプロイメントを有効にするかどうか。 | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | environment variables | `list(object({ name = string, value = string }))` | `[]` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | execution role arn | `string` | `""` | no |
| <a name="input_hostPort"></a> [hostPort](#input\_hostPort) | ロードバランサに対応するポート番号 | `number` | `80` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMSキーID（暗号化用） | `string` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | 起動タイプ（例: FARGATE） | `string` | `"FARGATE"` | no |
| <a name="input_lb_target_group_arn"></a> [lb\_target\_group\_arn](#input\_lb\_target\_group\_arn) | ターゲットグループARN（ALB/NLB） | `string` | `""` | no |
| <a name="input_lb_target_group_name_blue"></a> [lb\_target\_group\_name\_blue](#input\_lb\_target\_group\_name\_blue) | Blue環境用のターゲットグループの名前。enable\_blue\_green\_deployment が true の場合は必須。 | `string` | `null` | no |
| <a name="input_lb_target_group_name_green"></a> [lb\_target\_group\_name\_green](#input\_lb\_target\_group\_name\_green) | Green環境用のターゲットグループの名前。enable\_blue\_green\_deployment が true の場合は必須。 | `string` | `null` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | log group name | `string` | `""` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | CloudWatch Log Group のログ保持期間 (日数)。 | `number` | `365` | no |
| <a name="input_main_lb_listener_arn"></a> [main\_lb\_listener\_arn](#input\_main\_lb\_listener\_arn) | 本番トラフィックをルーティングするロードバランサーリスナーのARN。enable\_blue\_green\_deployment が true の場合は必須。 | `string` | `null` | no |
| <a name="input_memoryReservation"></a> [memoryReservation](#input\_memoryReservation) | memory Reservation | `number` | `1024` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Merged tags for resources | `map(string)` | `{}` | no |
| <a name="input_monitoring_enabled"></a> [monitoring\_enabled](#input\_monitoring\_enabled) | コンテナインサイト（モニタリング）を有効にするか | `bool` | `true` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming resources | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | suffix for naming resources | `string` | `""` | no |
| <a name="input_newrelic_api_key_secret_arn"></a> [newrelic\_api\_key\_secret\_arn](#input\_newrelic\_api\_key\_secret\_arn) | Secrets Manager ARN for NewRelic API key | `string` | `""` | no |
| <a name="input_newrelic_ecr_repository_url"></a> [newrelic\_ecr\_repository\_url](#input\_newrelic\_ecr\_repository\_url) | ECR URL for the newrelic-agent container | `string` | `""` | no |
| <a name="input_newrelic_image_tag"></a> [newrelic\_image\_tag](#input\_newrelic\_image\_tag) | Tag to use for the newrelic-agent container image | `string` | `"latest"` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | Fargate プラットフォームバージョン | `string` | `"LATEST"` | no |
| <a name="input_port_mapping_name"></a> [port\_mapping\_name](#input\_port\_mapping\_name) | port mapping name | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"ap-northeast-1"` | no |
| <a name="input_scale_in_cooldown"></a> [scale\_in\_cooldown](#input\_scale\_in\_cooldown) | スケールインのクールダウン時間（秒） | `number` | `60` | no |
| <a name="input_scale_out_cooldown"></a> [scale\_out\_cooldown](#input\_scale\_out\_cooldown) | スケールアウトのクールダウン時間（秒） | `number` | `60` | no |
| <a name="input_secret_variables"></a> [secret\_variables](#input\_secret\_variables) | environment variables | `list(object({ name = string, valueFrom = string }))` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | ECSサービスにアタッチするセキュリティグループID | `list(string)` | `[]` | no |
| <a name="input_service_assign_public_ip"></a> [service\_assign\_public\_ip](#input\_service\_assign\_public\_ip) | Whpf2er to assign a public IP to the Fargate tasks. | `bool` | `false` | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | The desired number of tasks for the service. | `number` | `1` | no |
| <a name="input_service_security_groups"></a> [service\_security\_groups](#input\_service\_security\_groups) | A list of security group IDs for the ECS service tasks. | `list(string)` | `[]` | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of subnet IDs for the ECS service tasks. | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | ECSサービスにアタッチするサブネットID | `list(string)` | `[]` | no |
| <a name="input_sysdig_api_key_secret_arn"></a> [sysdig\_api\_key\_secret\_arn](#input\_sysdig\_api\_key\_secret\_arn) | Secrets Manager ARN for Sysdig API key | `string` | `""` | no |
| <a name="input_sysdig_ecr_repository_url"></a> [sysdig\_ecr\_repository\_url](#input\_sysdig\_ecr\_repository\_url) | ECR URL for the sysdig-agent container | `string` | `""` | no |
| <a name="input_sysdig_image_tag"></a> [sysdig\_image\_tag](#input\_sysdig\_image\_tag) | Tag to use for the sysdig-agent container image | `string` | `"latest"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | リソースに付加するタグ | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | task cpu | `string` | `"512"` | no |
| <a name="input_task_definition_family"></a> [task\_definition\_family](#input\_task\_definition\_family) | タスク定義ファミリー名 | `string` | `""` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | task memory | `string` | `"1024"` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | task role arn | `string` | `""` | no |
| <a name="input_test_lb_listener_arn"></a> [test\_lb\_listener\_arn](#input\_test\_lb\_listener\_arn) | テストトラフィックをルーティングするロードバランサーリスナーのARN (オプション)。 | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | ECS タスクロググループの ARN。 |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | ECS タスクロググループの名前。 |
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | ECSクラスターのID |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | The ARN of the ECS task definition. |
| <a name="output_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#output\_ecs\_task\_definition\_family) | The family name of the ECS task definition. |
<!-- END_TF_DOCS -->
