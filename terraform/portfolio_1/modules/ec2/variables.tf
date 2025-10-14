# インスタンス名
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = ""
}

# AMI ID
variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = ""
}

# インスタンスタイプ
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# サブネットID（単一インスタンス用）
variable "ec2_subnet_id" {
  description = "Subnet ID where the instance will be deployed"
  type        = string
  default     = ""
}

# サブネットIDリスト（AutoScaling Group用）
variable "asg_subnet_ids" {
  description = "List of subnet IDs for Auto Scaling Group"
  type        = list(string)
  default     = []
}

# パブリックIP自動割り当ての有無
variable "associate_public_ip_address" {
  description = "Whpf2er to associate a public IP address"
  type        = bool
  default     = false
}

# セキュリティグループIDのリスト
variable "security_group_ids_ec2" {
  description = "List of security group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "security_group_ids_lb" {
  description = "List of security group IDs to associate with"
  type        = list(string)
  default     = []
}

# ルートボリュームサイズ（GB）
variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

# IAMインスタンスプロフィール名
variable "iam_instance_profile" {
  description = "IAM instance profile name to attach"
  type        = string
  default     = null
}

# ユーザーデータ（起動時スクリプト）
variable "user_data" {
  description = "User data script to run at launch"
  type        = string
  default     = ""
}

variable "user_data_replace_on_change" {
  description = "Recreate the EC2 instance when user_data changes"
  type        = bool
  default     = false
}

# タグ
variable "merged_tags" {
  description = "Merged tags for resources"
  type        = map(string)
  default     = {}
}

variable "enable_ec2" {
  description = "Whpf2er to create ec2 instance"
  type        = bool
  default     = false
}

variable "enable_autoscaling" {
  description = "Whpf2er to create Auto Scaling Group"
  type        = bool
  default     = false
}

variable "enable_alb" {
  description = "Whpf2er to create Application Load Balancer"
  type        = bool
  default     = false
}

variable "enable_elb" {
  description = "Whpf2er to create Network Load Balancer"
  type        = bool
  default     = false
}

variable "enable_launch_template" {
  description = "Whpf2er to create Launch Template"
  type        = bool
  default     = false
}

variable "key_pair_name" {
  description = "Name of the Key Pair"
  type        = string
  default     = null
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

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = null
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = null
}

variable "active_capacity_factor" {
  description = "Active capacity factor for the Auto Scaling Group"
  type        = number
  default     = 2
}


variable "refresh_buffer_factor" {
  description = "Refresh buffer factor for the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "alb_subnet_ids" {
  description = "List of subnet IDs to alb"
  type        = list(string)
  default     = []
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
  default     = ""
}

variable "lb_idle_timeout" {
  description = "Idle timeout for the ALB"
  type        = number
  default     = 60
}

variable "alb_scheme" {
  description = "ALB scheme, 'internet-facing' or 'internal'"
  type        = string
  default     = "internal"
}

variable "alb_ip_address_type" {
  description = "IP address type for the ALB (ipv4 or dualstack)"
  type        = string
  default     = "ipv4"
}

variable "target_type" {
  description = "target_type of load balancer"
  type        = string
  default     = "instance"
}

variable "target_protocol" {
  description = "target_protocol of load balancer"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "vpc_id of load balancer"
  type        = string
  default     = ""
}

variable "protocol" {
  description = "protocol of load balancer"
  type        = string
  default     = "HTTP"
}

variable "port" {
  description = "port of load balancer"
  type        = string
  default     = "80"
}

variable "lt_name" {
  description = "name of launch template"
  type        = string
  default     = ""
}

variable "lb_name" {
  description = "name of load blancer"
  type        = string
  default     = ""
}

variable "lb_tg_name" {
  description = "target group name of load blancer"
  type        = string
  default     = ""
}

variable "asg_name" {
  description = "auto scaling group name"
  type        = string
  default     = ""
}

variable "log_group_name" {
  description = "CloudWatch Logs log group name"
  type        = string
  default     = ""
}

variable "additional_volume_size" {
  description = "size of additional volume"
  type        = number
  default     = 20
}

variable "additional_volume_type" {
  description = "type of additional volume"
  type        = string
  default     = "gp3"
}

variable "main_listener_port" {
  description = "メインリスナーのポート。"
  type        = number
  default     = 80
}

variable "enable_test_listener" {
  description = "テスト用リスナーを有効にするか。"
  type        = bool
  default     = false
}

variable "test_listener_port" {
  description = "テスト用リスナーのポート。"
  type        = number
  default     = 280 # 例
}

# ヘルスチェックの変数
variable "health_check_path" {
  description = "ターゲットグループのヘルスチェックパス。"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "ターゲットグループのヘルスチェックプロトコル。"
  type        = string
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "ターゲットグループのヘルスチェック間隔 (秒)。"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "ターゲットグループのヘルスチェックタイムアウト (秒)。"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "ターゲットグループの健全な閾値。"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "ターゲットグループの異常な閾値。"
  type        = number
  default     = 2
}

variable "health_check_matcher" {
  description = "ターゲットグループのヘルスチェックHTTPコード。"
  type        = string
  default     = "200"
}

variable "warm_pool_min_size" {
  description = "Minimum number of instances in the warm pool"
  type        = number
  default     = 0
}

variable "warm_pool_max_group_prepared_capacity" {
  description = "Maximum number of instances in the warm pool"
  type        = number
  default     = 0
}

variable "warm_pool_reuse_on_scale_in" {
  description = "Whpf2er to reuse instances on scale-in by returning them to the warm pool"
  type        = bool
  default     = false
}

variable "lifecycle_hook_heartbeat_timeout" {
  description = "Heartbeat timeout for the lifecycle hook"
  type        = number
  default     = null
}

variable "ssl_policy" {
  description = "policy of ssl"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "arn of certificate"
  type        = string
  default     = ""
}

variable "target_port" {
  description = "port of target group"
  type        = string
  default     = "80"
}

# ASG 設定
variable "max_healthy_percentage" {
  description = "max healthy percentage for ASG"
  type        = number
  default     = "200"
}

# ASG 設定
variable "min_healthy_percentage" {
  description = "min healthy percentage for ASG"
  type        = number
  default     = "100"
}

variable "scale_out_policy_adjustment" {
  description = "Number of instances added when performing scale out"
  type        = number
  default     = 1
}

variable "scale_in_policy_adjustment" {
  description = "Number of instances removed when performing scale in"
  type        = number
  default     = -1
}

variable "scale_policy_cooldown" {
  description = "Cooldown period after scaling before allowing the next action"
  type        = number
  default     = 300
}

# CPU variables
variable "cpu_high_scale_out_threshold" {
  description = "CPU threshold to trigger scale-out"
  type        = number
  default     = 70
}

variable "cpu_high_scale_out_period" {
  description = "Period (in seconds) over which CPU utilization is evaluated for scale-out"
  type        = number
  default     = 300
}

variable "cpu_high_scale_out_evaluation_periods" {
  description = "Number of periods CPU must exceed threshold to trigger scale-out"
  type        = number
  default     = 1
}

variable "cpu_low_scale_in_threshold" {
  description = "CPU threshold to trigger scale-in"
  type        = number
  default     = 30
}

variable "cpu_low_scale_in_period" {
  description = "Period (in seconds) over which CPU utilization is evaluated for scale-in"
  type        = number
  default     = 300
}

variable "cpu_low_scale_in_evaluation_periods" {
  description = "Number of periods CPU must exceed threshold to trigger scale-in"
  type        = number
  default     = 3
}

# Memory variables

variable "memory_high_scale_out_threshold" {
  description = "Memory threshold to trigger scale-out"
  type        = number
  default     = 80
}

variable "memory_high_scale_out_period" {
  description = "Period (in seconds) to evaluate memory usage for scale-out"
  type        = number
  default     = 180
}

variable "memory_high_scale_out_evaluation_periods" {
  description = "Number of periods memory must exceed threshold to trigger scale-out"
  type        = number
  default     = 1
}

variable "memory_low_scale_in_threshold" {
  description = "Memory threshold to trigger scale-in"
  type        = number
  default     = 50
}

variable "memory_low_scale_in_period" {
  description = "Period (in seconds) to evaluate memory usage for scale-in"
  type        = number
  default     = 300
}

variable "memory_low_scale_in_evaluation_periods" {
  description = "Number of periods memory must stay below threshold to trigger scale-in"
  type        = number
  default     = 3
}

# Request_time variables

variable "request_time_high_scale_out_period" {
  description = "Duration of each metric period in seconds (e.g. 60)"
  type        = number
  default     = 60
}

variable "request_time_high_scale_out_evalution_periods" {
  description = "Number of periods required to trigger scale-out"
  type        = number
  default     = 3
}

variable "request_time_high_scale_out_threshold" {
  description = "Threshold for average request_time in seconds"
  type        = number
  default     = 0.5
}

variable "request_time_low_scale_in_period" {
  description = "Duration of each metric period in seconds"
  type        = number
  default     = 60
}

variable "request_time_low_scale_in_evalution_periods" {
  description = "Number of periods required to trigger scale-in"
  type        = number
  default     = 10
}

variable "request_time_low_scale_in_threshold" {
  description = "Threshold for average request_time to trigger scale-in"
  type        = number
  default     = 0.2
}

variable "enable_metrics" {
  description = "Whpf2er to enable ASG metrics"
  type        = bool
  default     = true
}

variable "lb_access_logs" {
  type = object({
    bucket = string
    prefix = optional(string)
  })
  default = null
}
