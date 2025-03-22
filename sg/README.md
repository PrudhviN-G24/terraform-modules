
---

### 📘 `security-group/README.md`

```markdown
# Terraform AWS Security Group Module

## 🚀 Features
- Creates reusable and customizable security groups
- Supports multiple ingress/egress rules
- Can be reused for EC2, RDS, ALB, ElastiCache, etc.
- Highly flexible via variable inputs

## 📥 Input Variables

| Name            | Type               | Description                        |
|------------------|--------------------|------------------------------------|
| name            | `string`           | Name of the SG                     |
| description     | `string`           | SG description                     |
| vpc_id          | `string`           | VPC to create the SG in            |
| ingress_rules   | `list(object)`     | List of ingress rule objects       |
| egress_rules    | `list(object)`     | List of egress rule objects        |
| tags            | `map(string)`      | Tags to apply                      |

## 📤 Outputs

| Name         | Description                |
|--------------|----------------------------|
| sg_id        | Security group ID          |
| sg_arn       | Security group ARN         |

## 🧩 Example Usage

```hcl
module "sg" {
  source = "../security-group"

  name        = "db-access"
  description = "SG for PostgreSQL access"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Env = "dev"
  }
}
