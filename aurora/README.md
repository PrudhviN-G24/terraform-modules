
---

### 📘 `aurora-cluster/README.md`

```markdown
# Terraform AWS Aurora Cluster Module

## 🚀 Features
- Creates Aurora DB cluster (PostgreSQL or MySQL)
- Multi-instance, HA-ready with writer/reader endpoint
- Creates subnet group and security group support
- Handles both cluster and instance creation

## 📥 Input Variables

| Name                     | Type              | Description                    |
|--------------------------|-------------------|--------------------------------|
| cluster_identifier       | `string`          | Cluster name                   |
| engine                   | `string`          | `aurora-mysql` or `aurora-postgresql` |
| engine_version           | `string`          | Engine version                 |
| database_name            | `string`          | Initial DB name                |
| master_username          | `string`          | Master username                |
| master_password          | `string`          | Master password                |
| vpc_security_group_ids   | `list(string)`    | List of SGs                    |
| subnet_ids               | `list(string)`    | Subnets for subnet group       |
| instance_class           | `string`          | Aurora instance type           |
| instance_count           | `number`          | Number of cluster instances    |
| backup_retention_period  | `number`          | Backup days                    |
| tags                     | `map(string)`     | Tags                           |

## 📤 Outputs

| Name              | Description               |
|-------------------|---------------------------|
| cluster_id        | ID of the Aurora cluster  |
| writer_endpoint   | Writer endpoint hostname  |
| reader_endpoint   | Reader endpoint hostname  |
| cluster_instance_ids | List of instance IDs   |

## 🧩 Example Usage

```hcl
module "aurora" {
  source = "../aurora-cluster"

  cluster_identifier = "abc241-dev-aurora"
  engine             = "aurora-postgresql"
  engine_version     = "15.3"
  database_name      = "bookstore"
  master_username    = "dbadmin"
  master_password    = "SecurePassword"
  instance_class     = "db.r6g.large"
  instance_count     = 2
  subnet_ids         = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.vpc.default_sg_id]
  tags = {
    Env = "dev"
  }
}
