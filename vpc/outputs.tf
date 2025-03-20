output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID (if enabled)"
  value       = var.enable_nat_gateway ? aws_nat_gateway.nat[0].id : null
}

output "s3_vpc_endpoint_id" {
  description = "S3 VPC Endpoint ID (if enabled)"
  value       = var.enable_s3_gateway_endpoint ? aws_vpc_endpoint.s3[0].id : null
}
