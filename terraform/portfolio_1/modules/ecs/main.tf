resource "aws_ecs_cluster" "this" {
  count = var.cluster_name != "" ? 1 : 0
  name  = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.monitoring_enabled ? "enabled" : "disabled"
  }
  tags = merge(var.merged_tags, {
    Name = var.cluster_name
  })
}

# クラスターの capacity_providers を指定
resource "aws_ecs_cluster_capacity_providers" "this" {
  count              = var.cluster_name != "" ? 1 : 0
  cluster_name       = aws_ecs_cluster.this[0].name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 0
  }
}

resource "aws_ecs_task_definition" "this" {
  count                    = var.task_definition_family != "" ? 1 : 0
  family                   = var.task_definition_family
  requires_compatibilities = [var.launch_type]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  pid_mode                 = var.sysdig_ecr_repository_url != "" && var.sysdig_image_tag != "" && var.sysdig_api_key_secret_arn != "" ? "task" : null

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode(concat(
    [
      {
        name              = var.container_name
        image             = var.container_image
        cpu               = var.container_cpu
        memoryReservation = var.memoryReservation
        essential         = true
        command           = var.container_command
        mountPoints       = var.mount_points != [] ? var.mount_points : null
        systemControls    = var.system_controls != [] ? var.system_controls : null
        entryPoint        = length(var.container_entrypoint) > 0 ? var.container_entrypoint : null
        command           = length(var.container_command) > 0 ? var.container_command : null

        portMappings = [
          {
            hostPort      = var.container_port
            containerPort = var.container_port
            protocol      = "tcp"
            appProtocol   = "http"
          }
        ]

        environment = var.environment_variables
        secrets     = var.secret_variables

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = aws_cloudwatch_log_group.task_log_group[0].name
            mode                  = "non-blocking"
            awslogs-create-group  = "true"
            max-buffer-size       = "25m"
            awslogs-region        = var.region
            awslogs-stream-prefix = element(split("/", var.container_name), length(split("/", var.container_name)) - 1)
          }
        },
        volumesFrom = var.sysdig_ecr_repository_url != "" ? [
          {
            sourceContainer = "sysdig-agent"
            readOnly        = true
          }
        ] : [],
        linuxParameters = {
          capabilities = {
            add  = ["SYS_PTRACE"]
            drop = var.capabilities_drop != [] ? var.capabilities_drop : null
          }
        }
      }
    ],
    var.sysdig_ecr_repository_url != "" && var.sysdig_image_tag != "" && var.sysdig_api_key_secret_arn != "" ? [
      {
        name              = "sysdig-agent"
        image             = "${var.sysdig_ecr_repository_url}:${var.sysdig_image_tag}"
        cpu               = 512
        memoryReservation = 1024
        essential         = false
        secrets = [
          {
            name      = "SYSDIG_ACCESS_KEY"
            valueFrom = var.sysdig_api_key_secret_arn
          }
        ]

        environment = [
          {
            name  = "SYSDIG_COLLECTOR"
            value = "ingest.au1.sysdig.com"
          },
          {
            name  = "SYSDIG_COLLECTOR_PORT"
            value = "6443"
          },
          {
            name  = "SYSDIG_API_ENDPOINT"
            value = "app.au1.sysdig.com"
          }
        ]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = aws_cloudwatch_log_group.task_log_group[0].name
            mode                  = "non-blocking"
            awslogs-create-group  = "true"
            max-buffer-size       = "25m"
            awslogs-region        = var.region
            awslogs-stream-prefix = element(split("/", var.container_name), length(split("/", var.container_name)) - 1)
          }
        }
      }
    ] : [],
    var.newrelic_ecr_repository_url != "" && var.newrelic_image_tag != "" && var.newrelic_api_key_secret_arn != "" ? [
      {
        name              = "newrelic-agent"
        image             = "${var.newrelic_ecr_repository_url}:${var.newrelic_image_tag}"
        cpu               = 256
        memoryReservation = 512
        essential         = false
        secrets = [
          {
            name      = "NRIA_LICENSE_KEY"
            valueFrom = var.newrelic_api_key_secret_arn
          }
        ]
        environment = [
          {
            name  = "NRIA_OVERRIDE_HOST_ROOT"
            value = ""
          },
          {
            name  = "NRIA_IS_FORWARD_ONLY"
            value = "true"
          },
          {
            name  = "FARGATE"
            value = "true"
          },
          {
            name  = "NRIA_PASSTHROUGH_ENVIRONMENT"
            value = "ECS_CONTAINER_METADATA_URI,ECS_CONTAINER_METADATA_URI_V4,FARGATE"
          },
          {
            name  = "NRIA_CUSTOM_ATTRIBUTES",
            value = "{\"nrDeployMpf2od\":\"downloadPage\"}"
          }
        ]
      }
    ] : []
  ))

  tags = merge(var.merged_tags, {
    Name = var.task_definition_family
  })
}

resource "aws_ecs_service" "this" {
  count                  = var.ecs_service_name != "" ? 1 : 0
  name                   = var.ecs_service_name
  cluster                = var.cluster_name != "" ? aws_ecs_cluster.this[0].id : var.cluster_id
  task_definition        = aws_ecs_task_definition.this[0].arn
  launch_type            = var.launch_type
  desired_count          = var.service_desired_count
  enable_execute_command = true

  # awsvpc ネットワークモードの場合に必須
  network_configuration {
    subnets          = var.service_subnets
    security_groups  = var.service_security_groups
    assign_public_ip = var.service_assign_public_ip
  }

  # capacity_provider_strategy を明示的に指定する場合
  # capacity_provider_strategy {
  #   capacity_provider = "FARGATE"
  #   weight            = 1
  # }
  # capacity_provider_strategy {
  #   capacity_provider = "FARGATE_SPOT"
  #   weight            = 0 # 必要に応じて調整
  # }

  # ロードバランサーを使用する場合の例
  dynamic "load_balancer" {
    for_each = var.lb_target_group_arn != "" ? [1] : []
    content {
      target_group_arn = var.lb_target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }
  # デプロイメントコントローラー: Blue/Green の場合に CODE_DEPLOY を設定
  deployment_controller {
    type = var.enable_blue_green_deployment ? "CODE_DEPLOY" : "ECS"
  }

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count,
      load_balancer,
      network_configuration
    ]
  }

  tags = merge(var.merged_tags, {
    Name = "${var.cluster_name}-${var.container_name}-service"
  })

  # depends_on = [
  #   aws_ecs_cluster_capacity_providers.this
  # ]
}

resource "aws_appautoscaling_target" "ecs" {
  count              = var.ecs_service_name != "" ? 1 : 0
  max_capacity       = var.autoscaling_max_capacity
  min_capacity       = var.autoscaling_min_capacity
  resource_id        = var.cluster_name != "" ? "service/${aws_ecs_cluster.this[0].name}/${aws_ecs_service.this[0].name}" : "service/${var.ecs_cluster_name}/${aws_ecs_service.this[0].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# 高CPUのCloudWatchアラーム
resource "aws_cloudwatch_metric_alarm" "svc_cpu_high" {
  count               = var.ecs_service_name != "" ? 1 : 0
  alarm_name          = "${var.name_prefix}-${var.ecs_service_name}-cpu-high-${var.scale_out_threshold}-for-${var.scale_out_evaluation_periods}m"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scale_out_evaluation_periods
  threshold           = var.scale_out_threshold
  treat_missing_data  = "notBreaching"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.scale_out_interval_period
  statistic           = "Average"
  dimensions = {
    ClusterName = aws_ecs_cluster.this[0].name
    ServiceName = aws_ecs_service.this[0].name
  }
  alarm_actions = [aws_appautoscaling_policy.step_out[0].arn]
}

resource "aws_appautoscaling_policy" "step_out" {
  count              = var.ecs_service_name != "" ? 1 : 0
  name               = "${var.ecs_service_name}-cpu-step-out"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs[0].service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_scaling_cooldown
    metric_aggregation_type = "Average"

    # しきい値以上 → 1台増やす
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

# 低CPUのCloudWatchアラーム
resource "aws_cloudwatch_metric_alarm" "svc_cpu_low" {
  count               = var.ecs_service_name != "" ? 1 : 0
  alarm_name          = "${var.name_prefix}-${var.ecs_service_name}-cpu-low-${var.scale_in_threshold}-for-${var.scale_in_evaluation_periods}m"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.scale_in_evaluation_periods
  threshold           = var.scale_in_threshold
  treat_missing_data  = "notBreaching"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.scale_in_interval_period
  statistic           = "Average"

  # サービス平均CPU（クラスタ＆サービス名で次元を固定）
  dimensions = {
    ClusterName = aws_ecs_cluster.this[0].name
    ServiceName = aws_ecs_service.this[0].name
  }
  alarm_actions = [aws_appautoscaling_policy.step_in[0].arn]
}

# Step Scaling ポリシー（スケールイン専用）
resource "aws_appautoscaling_policy" "step_in" {
  count              = var.ecs_service_name != "" ? 1 : 0
  name               = "${var.ecs_service_name}-cpu-step-in"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs[0].service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_in_scaling_cooldown
    metric_aggregation_type = "Average"

    # しきい値未満 → 1台減らす
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

# CloudWatch Logs グループ
resource "aws_cloudwatch_log_group" "task_log_group" {
  count = var.task_definition_family != "" ? 1 : 0
  name  = "/aws/ecs/${var.task_definition_family}"

  # 暗号化を有効にし、指定されたKMSキーを利用
  kms_key_id        = var.kms_key_id
  retention_in_days = var.log_retention_in_days
  tags = merge(var.merged_tags, {
    Name = "/aws/ecs/${var.task_definition_family}"
  })
}
