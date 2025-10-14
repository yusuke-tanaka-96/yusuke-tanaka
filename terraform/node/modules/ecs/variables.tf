# AWSリージョン
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "cluster_name" {
  description = "ECSクラスター名"
  type        = string
  default     = ""
}

variable "cluster_id" {
  description = "ECSクラスターID"
  type        = string
  default     = ""
}

variable "ecs_cluster_name" {
  description = "ECSクラスターID"
  type        = string
  default     = ""
}

variable "monitoring_enabled" {
  description = "コンテナインサイト（モニタリング）を有効にするか"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMSキーID（暗号化用）"
  type        = string
  default     = null
}

variable "task_definition_family" {
  description = "タスク定義ファミリー名"
  type        = string
  default     = ""
}

variable "launch_type" {
  description = "起動タイプ（例: FARGATE）"
  type        = string
  default     = "FARGATE"
}

variable "platform_version" {
  description = "Fargate プラットフォームバージョン"
  type        = string
  default     = "LATEST"
}

variable "desired_task_count" {
  description = "必要なタスク数"
  type        = number
  default     = 1
}

variable "deployment_min_percent" {
  description = "最小稼働タスク数（%）"
  type        = number
  default     = 100
}

variable "deployment_max_percent" {
  description = "最大稼働タスク数（%）"
  type        = number
  default     = 200
}

variable "assign_public_ip" {
  description = "パブリックIP割り当て（true = ENABLED）"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "ECSサービスにアタッチするサブネットID"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "ECSサービスにアタッチするセキュリティグループID"
  type        = list(string)
  default     = []
}

variable "lb_target_group_arn" {
  description = "ターゲットグループARN（ALB/NLB）"
  type        = string
  default     = ""
}

variable "container_name" {
  description = "ロードバランサに対応するコンテナ名"
  type        = string
  default     = ""
}

variable "container_port" {
  description = "コンテナポート番号"
  type        = number
  default     = 80
}

variable "hostPort" {
  description = "ロードバランサに対応するポート番号"
  type        = number
  default     = 80
}

variable "autoscaling_min" {
  description = "サービスのオートスケーリング最小数"
  type        = number
  default     = 1
}

variable "autoscaling_max" {
  description = "サービスのオートスケーリング最大数"
  type        = number
  default     = 3
}

variable "cpu_target_value" {
  description = "ターゲットとなるCPU使用率（%）"
  type        = number
  default     = 50
}

variable "scale_in_cooldown" {
  description = "スケールインのクールダウン時間（秒）"
  type        = number
  default     = 60
}

variable "scale_out_cooldown" {
  description = "スケールアウトのクールダウン時間（秒）"
  type        = number
  default     = 60
}

variable "tags" {
  description = "リソースに付加するタグ"
  type        = map(string)
  default     = {}
}

# タグ
variable "merged_tags" {
  description = "Merged tags for resources"
  type        = map(string)
  default     = {}
}

# ネームプレフィックス
variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = ""
}

# ネームサフィックス
variable "name_suffix" {
  description = "suffix for naming resources"
  type        = string
  default     = ""
}

variable "task_cpu" {
  description = "task cpu"
  type        = string
  default     = "512"
}

variable "task_memory" {
  description = "task memory"
  type        = string
  default     = "1024"
}

variable "execution_role_arn" {
  description = "execution role arn"
  type        = string
  default     = ""
}

variable "task_role_arn" {
  description = "task role arn"
  type        = string
  default     = ""
}

variable "container_image" {
  description = "tcontainer image"
  type        = string
  default     = ""
}

variable "environment_variables" {
  description = "environment variables"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "secret_variables" {
  description = "environment variables"
  type        = list(object({ name = string, valueFrom = string }))
  default     = []
}

# variable "environment_variables" {
#   description = "environment variables"
#   type        = map(string)
#   default     = {}
# }

variable "ecs_task_name" {
  description = "ecs task name"
  type        = string
  default     = ""
}

variable "log_group_name" {
  description = "log group name"
  type        = string
  default     = ""
}

variable "service_desired_count" {
  description = "The desired number of tasks for the service."
  type        = number
  default     = 1
}

variable "service_subnets" {
  description = "A list of subnet IDs for the ECS service tasks."
  type        = list(string)
  default     = []
}

variable "service_security_groups" {
  description = "A list of security group IDs for the ECS service tasks."
  type        = list(string)
  default     = []
}

variable "service_assign_public_ip" {
  description = "Whpf2er to assign a public IP to the Fargate tasks."
  type        = bool
  default     = false
}

variable "ecs_service_name" {
  description = "ecs service name"
  type        = string
  default     = ""
}

variable "port_mapping_name" {
  description = "port mapping name"
  type        = string
  default     = ""
}

variable "container_cpu" {
  description = "container cpu"
  type        = number
  default     = 512
}
variable "memoryReservation" {
  description = "memory Reservation"
  type        = number
  default     = 1024
}

variable "autoscaling_min_capacity" {
  type        = number
  description = "最小タスク数"
  default     = 0
}

variable "autoscaling_max_capacity" {
  type        = number
  description = "最大タスク数"
  default     = 5
}

variable "autoscaling_cpu_target_value" {
  type        = number
  description = "CPU使用率のターゲット値（%）"
  default     = 70
}

variable "autoscaling_scale_in_cooldown" {
  type        = number
  description = "スケールインのクールダウン時間（秒）"
  default     = 300
}

variable "autoscaling_scale_out_cooldown" {
  type        = number
  description = "スケールアウトのクールダウン時間（秒）"
  default     = 300
}

variable "deployment_maximum_percent" {
  description = "デプロイ中にRunningステータスにあるタスクの最大パーセンテージ。CodeDeployまたはECSサービスが管理します。"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "デプロイ中にRunningステータスにあるタスクの最小パーセンテージ。CodeDeployまたはECSサービスが管理します。"
  type        = number
  default     = 100
}

variable "enable_blue_green_deployment" {
  description = "Blue/Green デプロイメントを有効にするかどうか。"
  type        = bool
  default     = false
}

variable "lb_target_group_name_blue" {
  description = "Blue環境用のターゲットグループの名前。enable_blue_green_deployment が true の場合は必須。"
  type        = string
  default     = null
}

variable "lb_target_group_name_green" {
  description = "Green環境用のターゲットグループの名前。enable_blue_green_deployment が true の場合は必須。"
  type        = string
  default     = null
}

variable "main_lb_listener_arn" {
  description = "本番トラフィックをルーティングするロードバランサーリスナーのARN。enable_blue_green_deployment が true の場合は必須。"
  type        = string
  default     = null
}

variable "test_lb_listener_arn" {
  description = "テストトラフィックをルーティングするロードバランサーリスナーのARN (オプション)。"
  type        = string
  default     = null
}

variable "blue_green_deployment_ready_action_on_timeout" {
  description = "デプロイ承認タイムアウト時の動作 ('CONTINUE_DEPLOYMENT', 'STOP_DEPLOYMENT')."
  type        = string
  default     = "CONTINUE_DEPLOYMENT"
  validation {
    condition     = contains(["CONTINUE_DEPLOYMENT", "STOP_DEPLOYMENT"], var.blue_green_deployment_ready_action_on_timeout)
    error_message = "blue_green_deployment_ready_action_on_timeout は 'CONTINUE_DEPLOYMENT' または 'STOP_DEPLOYMENT' である必要があります。"
  }
}

variable "blue_green_deployment_ready_wait_time_in_minutes" {
  description = "デプロイ承認待機時間 (分)。手動承認を使用しない場合は 0。"
  type        = number
  default     = 0
}

variable "blue_green_terminate_action" {
  description = "成功時に古いインスタンスを終了する方法 ('TERMINATE', 'RETAIN')."
  type        = string
  default     = "TERMINATE"
  validation {
    condition     = contains(["TERMINATE", "RETAIN"], var.blue_green_terminate_action)
    error_message = "blue_green_terminate_action は 'TERMINATE' または 'RETAIN' である必要があります。"
  }
}

variable "blue_green_terminate_wait_time_in_minutes" {
  description = "古いインスタンス終了までの待機時間 (分)。"
  type        = number
  default     = 5
}

variable "codedeploy_service_role_arn" {
  description = "AWS CodeDeployがサービスにアクセスするためのIAMロールのARN。enable_blue_green_deployment が true の場合は必須。"
  type        = string
  default     = null
}

variable "log_retention_in_days" {
  description = "CloudWatch Log Group のログ保持期間 (日数)。"
  type        = number
  default     = 30
}

variable "container_command" {
  description = "Command to run inside the container"
  type        = list(string)
  default     = []
}

# sysdig用の変数
variable "sysdig_api_key_secret_arn" {
  description = "Secrets Manager ARN for Sysdig API key"
  type        = string
  default     = ""
}

# sysdig用のecr repository url
variable "sysdig_ecr_repository_url" {
  description = "ECR URL for the sysdig-agent container"
  type        = string
  default     = ""
}

# sysdig用のimage tag
variable "sysdig_image_tag" {
  description = "Tag to use for the sysdig-agent container image"
  type        = string
  default     = "latest"
}

# new relic用
variable "newrelic_api_key_secret_arn" {
  description = "Secrets Manager ARN for NewRelic API key"
  type        = string
  default     = ""
}

# new relic用のecr repository url
variable "newrelic_ecr_repository_url" {
  description = "ECR URL for the newrelic-agent container"
  type        = string
  default     = ""
}

# new relic用のimage tag
variable "newrelic_image_tag" {
  description = "Tag to use for the newrelic-agent container image"
  type        = string
  default     = "latest"
}

variable "mount_points" {
  description = ""
  type        = list(string)
  default     = []
}

variable "system_controls" {
  description = ""
  type        = list(string)
  default     = []
}

variable "capabilities_drop" {
  description = ""
  type        = list(string)
  default     = []
}

variable "scale_in_evaluation_periods" {
  description = "CloudWatch alarm evaluation periods(min) of scale in"
  type        = number
  default     = 5
}
variable "scale_in_threshold" {
  description = "cpu utilization threshold(%) of scale in"
  type        = number
  default     = 30
}
variable "scale_in_interval_period" {
  description = "The interval period of metrics collect(s) of scale in"
  type        = number
  default     = 60
}
variable "scale_in_scaling_cooldown" {
  description = "The scaling_cooldown of scale in"
  type        = number
  default     = 180
}


variable "scale_out_evaluation_periods" {
  description = "CloudWatch alarm evaluation periods(min) of scale out"
  type        = number
  default     = 5
}
variable "scale_out_threshold" {
  description = "cpu utilization threshold(%) of scale out"
  type        = number
  default     = 70
}
variable "scale_out_interval_period" {
  description = "The interval period of metrics collect(s) of scale out"
  type        = number
  default     = 60
}
variable "scale_out_scaling_cooldown" {
  description = "The scaling cooldown of scale out"
  type        = number
  default     = 180
}
variable "container_entrypoint" {
  description = "Override container ENTRYPOINT"
  type        = list(string)
  default     = []
}
