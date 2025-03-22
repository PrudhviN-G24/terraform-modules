
---

### 📘 `s3/README.md`

```markdown
# Terraform AWS S3 Module

## 🚀 Features
- Creates versioned, encrypted S3 bucket
- Optional lifecycle policies
- Public access block
- Logging and tagging support

## 📥 Input Variables

| Name             | Type            | Description                     |
|------------------|------------------|---------------------------------|
| bucket_name      | `string`        | Name of the S3 bucket           |
| versioning       | `bool`          | Enable versioning               |
| lifecycle_rules  | `list(object)`  | Lifecycle rule configurations   |
| tags             | `map(string)`   | Tags for the bucket             |

## 📤 Outputs

| Name             | Description             |
|------------------|-------------------------|
| bucket_id        | Name of the S3 bucket   |
| bucket_arn       | ARN of the S3 bucket    |

## 🧩 Example Usage

```hcl
module "s3" {
  source      = "../s3"
  bucket_name = "abc241-dev-logs"
  versioning  = true
  tags = {
    Env = "dev"
  }
}
