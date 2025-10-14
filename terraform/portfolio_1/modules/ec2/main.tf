resource "aws_instance" "this" {
  count                       = var.instance_name != "" ? 1 : 0
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.ec2_subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.security_group_ids_ec2
  key_name                    = var.key_pair_name
  iam_instance_profile        = var.iam_instance_profile != null ? var.iam_instance_profile : null
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }

  # Nameタグを追加（merged_tagsに加えてNameを付与）
  tags = merge(
    {
      Name = var.instance_name
    },
    var.merged_tags
  )

  metadata_options {
    http_tokens   = "required" # IMDSv2を必須化
    http_endpoint = "enabled"  # メタデータサービスは有効
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_launch_template" "this" {
  count         = var.lt_name != "" ? 1 : 0
  name          = var.lt_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_pair_name
  iam_instance_profile {
    name = var.iam_instance_profile
  }

  user_data = base64gzip(var.user_data)

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }

  network_interfaces {
    subnet_id       = var.ec2_subnet_id
    security_groups = var.security_group_ids_ec2
  }


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.name_prefix}-lt-${var.name_suffix}"
      Environment = var.merged_tags.Environment
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "this" {
  count              = var.lb_name != "" ? 1 : 0
  name               = var.lb_name
  load_balancer_type = var.load_balancer_type # "application" or "network"
  security_groups    = var.security_group_ids_lb
  subnets            = var.alb_subnet_ids

  internal        = true
  ip_address_type = var.alb_ip_address_type # "ipv4" or "dualstack"

  enable_deletion_protection = false
  idle_timeout               = var.lb_idle_timeout

  dynamic "access_logs" {
    for_each = var.lb_access_logs != null ? [var.lb_access_logs] : []
    content {
      bucket  = access_logs.value.bucket
      prefix  = lookup(access_logs.value, "prefix", null)
      enabled = true
    }
  }

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-alb"
  })
}

# メインリスナー
resource "aws_lb_listener" "main" {
  count             = var.lb_name != "" ? 1 : 0
  load_balancer_arn = aws_lb.this[0].arn
  port              = var.main_listener_port
  protocol          = var.protocol
  ssl_policy        = try(var.ssl_policy)
  certificate_arn   = try(var.certificate_arn)

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue[0].arn # ここではBlueをデフォルトとする
  }
  lifecycle {
    ignore_changes = [
      default_action[0].target_group_arn
    ]
  }
}

# テストリスナー (Blue/Green用, オプション)
resource "aws_lb_listener" "test" {
  count             = var.enable_test_listener && var.lb_name != "" ? 1 : 0
  load_balancer_arn = aws_lb.this[0].arn
  port              = var.test_listener_port
  protocol          = var.protocol
  ssl_policy        = try(var.ssl_policy)
  certificate_arn   = try(var.certificate_arn)
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green[0].arn # Greenをデフォルトとする
  }

  lifecycle {
    ignore_changes = [
      default_action[0].target_group_arn
    ]
  }
}

resource "aws_lb_target_group" "blue" {
  count       = var.lb_name != "" ? 1 : 0
  name        = "${var.lb_tg_name}-blue" # Blue環境用
  port        = var.target_port
  protocol    = var.target_protocol != null ? var.target_protocol : var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }

  tags = merge(var.merged_tags, {
    Name  = "${var.lb_tg_name}-blue"
    Color = "blue"
  })
}

resource "aws_lb_target_group" "green" {
  count       = var.enable_test_listener && var.lb_name != "" ? 1 : 0
  name        = "${var.lb_tg_name}-green" # Green環境用
  port        = var.target_port
  protocol    = var.target_protocol != null ? var.target_protocol : var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }

  tags = merge(var.merged_tags, {
    Name  = "${var.lb_tg_name}-green"
    Color = "green"
  })
}

# # リスナー
# resource "aws_lb_listener" "http" {
#   count             = var.lb_name != "" ? 1 : 0
#   load_balancer_arn = aws_lb.this[0].arn
#   port              = var.port
#   protocol          = var.protocol
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this[0].arn
#   }
# }

# # ターゲットグループ
# resource "aws_lb_target_group" "this" {
#   count       = var.lb_name != "" ? 1 : 0
#   name        = "${var.name_prefix}-tg-${var.name_suffix}"
#   port        = var.port
#   protocol    = var.protocol
#   vpc_id      = var.vpc_id
#   target_type = var.target_type

#   health_check {
#     path                = "/"
#     protocol            = "HTTP"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }

#   tags = merge(var.merged_tags, {
#     Name = var.lb_tg_name
#   })
# }

resource "aws_autoscaling_group" "this" {
  count = var.asg_name != "" ? 1 : 0
  name  = var.asg_name

  launch_template {
    id      = aws_launch_template.this[0].id
    version = aws_launch_template.this[0].latest_version
  }

  min_size         = var.min_size
  max_size         = var.max_size != null ? var.max_size : var.desired_capacity * var.active_capacity_factor * var.refresh_buffer_factor + var.warm_pool_min_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier       = var.asg_subnet_ids
  health_check_type         = "ELB"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "0"
  target_group_arns         = length(aws_lb_target_group.blue) > 0 ? [aws_lb_target_group.blue[0].arn] : []
  instance_maintenance_policy {
    max_healthy_percentage = var.max_healthy_percentage
    min_healthy_percentage = var.min_healthy_percentage
  }

  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = false
  }

  warm_pool {
    pool_state                  = "Running"
    min_size                    = var.warm_pool_min_size
    max_group_prepared_capacity = var.warm_pool_max_group_prepared_capacity

    instance_reuse_policy {
      reuse_on_scale_in = var.warm_pool_reuse_on_scale_in
    }
  }

  dynamic "initial_lifecycle_hook" {
    for_each = var.lifecycle_hook_heartbeat_timeout != null ? [1] : []
    content {
      name                 = "${var.asg_name}-lifecycle-hook-instance-launching"
      default_result       = "CONTINUE"
      heartbeat_timeout    = var.lifecycle_hook_heartbeat_timeout
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    }
  }

  enabled_metrics = var.enable_metrics ? [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolMinSize",
    "WarmPoolDesiredCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ] : null

  instance_refresh {
    strategy = "Rolling"
    triggers = ["launch_template"]
  }
}

resource "aws_autoscaling_policy" "scale_out" {
  count                  = var.asg_name != "" ? 1 : 0
  name                   = "${var.asg_name}-scale-out-policy"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_policy_cooldown
  scaling_adjustment     = var.scale_out_policy_adjustment
  autoscaling_group_name = aws_autoscaling_group.this[0].name
}

resource "aws_autoscaling_policy" "scale_in" {
  count                  = var.asg_name != "" ? 1 : 0
  name                   = "${var.asg_name}-scale-in-policy"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_policy_cooldown
  scaling_adjustment     = var.scale_in_policy_adjustment
  autoscaling_group_name = aws_autoscaling_group.this[0].name
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count             = var.asg_name != "" ? 1 : 0
  alarm_name        = "${var.asg_name}-cpu-high"
  alarm_description = "Scale-out when CPU > ${var.cpu_high_scale_out_threshold}% for 5 minutes"
  namespace         = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this[0].name
  }
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = var.cpu_high_scale_out_period
  evaluation_periods  = var.cpu_high_scale_out_evaluation_periods
  threshold           = var.cpu_high_scale_out_threshold
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_autoscaling_policy.scale_out[0].arn]
  actions_enabled     = false
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count             = var.asg_name != "" ? 1 : 0
  alarm_name        = "${var.asg_name}-cpu-low"
  alarm_description = "Scale-in When CPU < ${var.cpu_low_scale_in_threshold}% for 15 minutes"
  namespace         = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this[0].name
  }
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = var.cpu_low_scale_in_period
  evaluation_periods  = var.cpu_low_scale_in_evaluation_periods
  threshold           = var.cpu_low_scale_in_threshold
  comparison_operator = "LessThanThreshold"
  alarm_actions       = [aws_autoscaling_policy.scale_in[0].arn]
  actions_enabled     = false
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  count             = var.asg_name != "" ? 1 : 0
  alarm_name        = "${var.asg_name}-memory-high"
  alarm_description = "Scale-out when Memory > 80% for 3 minutes"
  namespace         = "Custom/ASG"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this[0].name
  }
  metric_name         = "mem_used_percent"
  statistic           = "Average"
  period              = var.memory_high_scale_out_period
  evaluation_periods  = var.memory_high_scale_out_evaluation_periods
  threshold           = var.memory_high_scale_out_threshold
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_autoscaling_policy.scale_out[0].arn]
  actions_enabled     = false
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  count             = var.asg_name != "" ? 1 : 0
  alarm_name        = "${var.asg_name}-memory-low"
  alarm_description = "Scale-in when Memory < 50% for 15 minutes"
  namespace         = "Custom/ASG"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this[0].name
  }
  metric_name         = "mem_used_percent"
  statistic           = "Average"
  period              = var.memory_low_scale_in_period
  evaluation_periods  = var.memory_low_scale_in_evaluation_periods
  threshold           = var.memory_low_scale_in_threshold
  comparison_operator = "LessThanThreshold"
  alarm_actions       = [aws_autoscaling_policy.scale_in[0].arn]
  actions_enabled     = false
}

resource "aws_cloudwatch_log_metric_filter" "request_time" {
  count          = (var.asg_name != "" && var.log_group_name != "") ? 1 : 0
  name           = "${aws_autoscaling_group.this[0].name}-nginx-request-time"
  log_group_name = "${var.log_group_name}-nginx-access-log"
  pattern        = "[ip, dash1, dash2, time, request, status_code, size, referrer, user_agent, trace_info, request_time, asg_name]"
  metric_transformation {
    namespace = "Custom/ASG"
    dimensions = {
      AutoScalingGroupName = "$asg_name"
    }
    name  = "RequestTime"
    value = "$request_time"
  }
}

resource "aws_cloudwatch_metric_alarm" "request_time_high" {
  count             = (var.asg_name != "" && var.log_group_name != "") ? 1 : 0
  alarm_name        = "${var.asg_name}-request-time-high"
  alarm_description = "Trigger scale-out when request_time > 500ms for 3 minutes"
  namespace         = "Custom/ASG"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this[0].name
  }
  metric_name         = "RequestTime"
  statistic           = "Average"
  period              = var.request_time_high_scale_out_period
  evaluation_periods  = var.request_time_high_scale_out_evalution_periods
  threshold           = var.request_time_high_scale_out_threshold
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"
  alarm_actions       = [aws_autoscaling_policy.scale_out[0].arn]
}

resource "aws_cloudwatch_metric_alarm" "request_time_low" {
  count             = (var.asg_name != "" && var.log_group_name != "") ? 1 : 0
  alarm_name        = "${var.asg_name}-request-time-low"
  alarm_description = "Trigger scale-in when request_time < 200ms for 10 minutes"
  namespace         = "Custom/ASG"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this[0].name
  }
  metric_name         = "RequestTime"
  statistic           = "Average"
  period              = var.request_time_low_scale_in_period
  evaluation_periods  = var.request_time_low_scale_in_evalution_periods
  threshold           = var.request_time_low_scale_in_threshold
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "missing"
  alarm_actions       = [aws_autoscaling_policy.scale_in[0].arn]
}
