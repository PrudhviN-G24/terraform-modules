
---

### 📘 `ec2/README.md`

```markdown
# Terraform AWS EC2 Module

## 🚀 Features
- Launch EC2 instance (Linux/Windows/custom AMI)
- Support for key pair, user data, SGs, EBS volume
- Optional public IP, instance profile

## 📥 Input Variables

| Name            | Type            | Description                       |
|------------------|------------------|-----------------------------------|
| ami_id           | `string`        | AMI ID to launch                  |
| instance_type    | `string`        | EC2 instance type                 |
| key_name         | `string`        | SSH key pair                      |
| subnet_id        | `string`        | Subnet ID                         |
| vpc_security_group_ids | `list(string)` | Security groups                  |
| user_data        | `string`        | Bootstrap script (optional)       |
| tags             | `map(string)`   | Tags                              |

## 📤 Outputs

| Name            | Description              |
|------------------|--------------------------|
| instance_id     | EC2 instance ID          |
| public_ip       | Public IP (if enabled)   |

## 🧩 Example Usage

```hcl
module "ec2" {
  source      = "../ec2"
  ami_id      = "ami-123456"
  instance_type = "t3.micro"
  key_name    = "dev-key"
  subnet_id   = "subnet-abc123"
  vpc_security_group_ids = ["sg-01234"]
  user_data   = file("scripts/linux-init.sh")
  tags = {
    Name = "web-server"
    Env  = "dev"
  }
}
