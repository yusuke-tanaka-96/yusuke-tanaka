# EC2インスタンスIDの出力
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = var.instance_name != "" ? aws_instance.this[0].id : null
}

# パブリックIP（もし付与されていれば）
output "public_ip" {
  description = "The public IP address assigned to the EC2 instance"
  value       = var.instance_name != "" ? aws_instance.this[0].public_ip : null
}

# プライベートIP
output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = var.instance_name != "" ? aws_instance.this[0].private_ip : null
}

# インスタンスのARN
output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = var.instance_name != "" ? aws_instance.this[0].arn : null
}

output "launch_template_id" {
  description = "ID of the created Launch Template"
  value       = var.lt_name != "" ? aws_launch_template.this[0].id : null
}

output "launch_template_name" {
  description = "The name of the Launch Template."
  value       = var.lt_name != "" ? aws_launch_template.this[0].name : null
}

# ロードバランサーの出力
output "lb_arn" {
  description = "The ARN of the Load Balancer."
  value       = var.lb_name != "" ? aws_lb.this[0].arn : null
}

output "lb_dns_name" {
  description = "The DNS name of the Load Balancer."
  value       = var.lb_name != "" ? aws_lb.this[0].dns_name : null
}

output "lb_zone_id" {
  description = "The Zone ID of the Load Balancer."
  value       = var.lb_name != "" ? aws_lb.this[0].zone_id : null
}

# ロードバランサーリスナーの出力
# output "lb_listener_arn" {
#   description = "The ARN of the Load Balancer Listener."
#   value       = var.lb_name != "" ? aws_lb_listener.http[0].arn : null
# }

# ターゲットグループの出力
# output "lb_target_group_arn" {
#   description = "The ARN of the Load Balancer Target Group."
#   value       = var.lb_name != "" ? aws_lb_target_group.this[0].arn : null
# }

# output "lb_target_group_name" {
#   description = "The name of the Load Balancer Target Group."
#   value       = var.lb_name != "" ? aws_lb_target_group.this[0].name : null
# }

# オートスケーリンググループの出力
output "autoscaling_group_arn" {
  description = "The ARN of the Auto Scaling Group."
  value       = var.asg_name != "" ? aws_autoscaling_group.this[0].arn : null
}

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group."
  value       = var.asg_name != "" ? aws_autoscaling_group.this[0].name : null
}


output "lb_listener_main_arn" {
  description = "メインのロードバランサーリスナーのARN。"
  value       = var.lb_name != "" ? aws_lb_listener.main[0].arn : null
}

output "lb_listener_test_arn" {
  description = "テスト用のロードバランサーリスナーのARN (オプション)。"
  value       = var.enable_test_listener ? aws_lb_listener.test[0].arn : null
}

output "lb_target_group_arn_blue" {
  description = "BlueターゲットグループのARN。"
  value       = var.lb_name != "" ? aws_lb_target_group.blue[0].arn : null
}

output "lb_target_group_arn_green" {
  description = "GreenターゲットグループのARN。"
  value       = var.enable_test_listener && var.lb_name != "" ? aws_lb_target_group.green[0].arn : null
}

output "lb_target_group_name_blue" {
  description = "Blueターゲットグループの名前。"
  value       = var.lb_name != "" ? aws_lb_target_group.blue[0].name : null
}

output "lb_target_group_name_green" {
  description = "Greenターゲットグループの名前。"
  value       = var.enable_test_listener && var.lb_name != "" ? aws_lb_target_group.green[0].name : null
}