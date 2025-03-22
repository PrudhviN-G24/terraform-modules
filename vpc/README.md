# Terraform AWS VPC Module

## 🚀 Features
- Creates a custom VPC with configurable CIDR
- Public and private subnets across multiple AZs
- Internet Gateway and optional NAT Gateway
- Route tables for public/private subnets
- Auto-tagged subnets for Kubernetes (EKS ready)

## 📥 Input Variables

| Name                  | Type          | Description                      |
|-----------------------|---------------|----------------------------------|
| environment           | `string`      | Environment name (prefix)        |
| cidr_block            | `string`      | CIDR block for the VPC           |
| public_subnet_cidrs   | `list(string)`| List of public subnet CIDRs      |
| private_subnet_cidrs  | `list(string)`| List of private subnet CIDRs     |
| tags                  | `map(string)` | Common resource tags             |

## 📤 Outputs

| Name             | Description               |
|------------------|---------------------------|
| vpc_id           | ID of the created VPC     |
| public_subnet_ids| List of public subnet IDs |
| private_subnet_ids| List of private subnet IDs|
| default_sg_id    | Default SG ID for the VPC |

## 🧩 Example Usage

```hcl
module "vpc" {
  source               = "../vpc"
  environment          = "abc241-dev"
  cidr_block           = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  tags = {
    Owner = "devops"
    Env   = "dev"
  }
}
