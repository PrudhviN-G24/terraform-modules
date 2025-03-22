
---

### 📘 `iam/README.md`

```markdown
# Terraform AWS IAM Module

## 🚀 Features
- Creates IAM role with custom assume policy
- Attaches AWS-managed or inline policies
- Supports tagging and reuse across services

## 📥 Input Variables

| Name              | Type            | Description                      |
|--------------------|----------------|----------------------------------|
| role_name          | `string`       | Name of the IAM role             |
| assume_role_policy | `string`       | Trust policy in JSON             |
| managed_policy_arns | `list(string)`| AWS or custom policy ARNs        |
| inline_policies    | `map(string)`  | Name → JSON inline policy map    |
| tags               | `map(string)`  | Resource tags                    |

## 📤 Outputs

| Name           | Description         |
|----------------|---------------------|
| iam_role_name  | IAM role name       |
| iam_role_arn   | IAM role ARN        |

## 🧩 Example Usage

```hcl
module "iam" {
  source = "../iam"
  role_name = "ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}
