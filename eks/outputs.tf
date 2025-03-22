output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "node_group_name" {
  value = try(aws_eks_node_group.this[0].node_group_name, null)
}

output "fargate_profile_name" {
  value = try(aws_eks_fargate_profile.this[0].fargate_profile_name, null)
}

output "installed_addons" {
  value = keys(aws_eks_addon.addons)
}
