output "cluster_id" {
  value = aws_rds_cluster.this.id
}

output "writer_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

output "cluster_instance_ids" {
  value = aws_rds_cluster_instance.this[*].id
}
