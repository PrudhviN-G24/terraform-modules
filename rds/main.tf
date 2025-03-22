resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge({ Name = "${var.identifier}-subnet-group" }, var.tags)
}

resource "aws_db_instance" "this" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  #name                    = var.db_name
  username                = var.username
  password                = var.password
  multi_az                = var.multi_az
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  publicly_accessible     = var.publicly_accessible
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period

  tags = merge({
    Name = var.identifier
  }, var.tags)
}
