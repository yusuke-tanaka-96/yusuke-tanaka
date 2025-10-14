resource "aws_codedeploy_app" "this" {
  name             = var.app_name
  compute_platform = "ECS"
  tags             = var.tags
}

resource "aws_codedeploy_deployment_group" "this" {
  for_each               = { for dg in var.deployment_groups : dg.deployment_group_name => dg }
  app_name               = aws_codedeploy_app.this.name
  deployment_group_name  = each.value.deployment_group_name
  service_role_arn       = var.service_role_arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = each.value.cluster_name
    service_name = each.value.service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = each.value.listener_arns
      }
      target_group {
        name = each.value.target_group_blue
      }
      target_group {
        name = each.value.target_group_green
      }
    }
  }
  tags = var.tags
}
