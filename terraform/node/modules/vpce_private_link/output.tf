
output "vpc_endpoint_id" {
  value       = aws_vpc_endpoint.this.id
  description = "The ID of the created VPC endpoint"
}

output "network_interface_ids" {
  value       = aws_vpc_endpoint.this.network_interface_ids
  description = "The network interface IDs attached to this VPC endpoint"
}
