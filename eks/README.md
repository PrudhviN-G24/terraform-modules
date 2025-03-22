
---

### 📘 `eks/README.md`

```markdown
# Terraform AWS EKS Cluster (All-in-One) Module

## 🚀 Features
- Creates EKS cluster with toggle support
- Optional EC2 node groups
- Optional Fargate profiles
- Optional VPC tagging + IAM role creation
- Add-on support: vpc-cni, coredns, kube-proxy
- IRSA-ready

## 📥 Input Variables

| Name                   | Type          | Description                   |
|------------------------|---------------|-------------------------------|
| cluster_name           | `string`      | EKS cluster name              |
| kubernetes_version     | `string`      | K8s version                   |
| vpc_id                 | `string`      | VPC ID                        |
| subnet_ids             | `list(string)`| Subnet IDs                    |
| environment            | `string`      | Environment name              |
| enable_node_group      | `bool`        | Toggle for EC2 node group     |
| enable_fargate         | `bool`        | Toggle for Fargate            |
| instance_types         | `list(string)`| Node group instance types     |
| fargate_selectors      | `list(object)`| Namespace/labels for Fargate  |
| addons                 | `map(object)` | Add-ons like vpc-cni, etc.    |
| tags                   | `map(string)` | Tags                          |

## 📤 Outputs

| Name                  | Description                 |
|-----------------------|-----------------------------|
| cluster_name          | Name of the cluster         |
| cluster_endpoint      | EKS API endpoint            |
| node_group_name       | Node group name (if any)    |
| fargate_profile_name  | Fargate profile name (if any)|
| installed_addons      | List of installed add-ons   |

## 🧩 Example Usage

```hcl
module "eks" {
  source = "../eks"
  cluster_name = "abc241-dev-eks"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  enable_node_group = true
  instance_types = ["t3.medium"]

  addons = {
    vpc-cni = {
      addon_version = "v1.14.1-eksbuild.1"
    }
    coredns = {
      addon_version = "v1.11.1-eksbuild.4"
    }
  }

  tags = {
    Env = "dev"
  }
}




# Terraform AWS EKS IRSA (IAM Roles for Service Accounts) Module

## 🚀 Features
- Associates OIDC provider with EKS cluster (if not already)
- Creates IAM role with trust policy for specific service account
- Supports namespaced service account targeting
- Fully IRSA-ready for use in Kubernetes

## 📥 Input Variables

| Name                    | Type          | Description                          |
|-------------------------|---------------|--------------------------------------|
| cluster_name            | `string`      | EKS cluster name                     |
| irsa_role_name          | `string`      | IAM role name                        |
| namespace               | `string`      | K8s namespace for the service account|
| service_account_name    | `string`      | Service account name                 |
| policy_arn              | `string`      | IAM policy to attach                 |
| tags                    | `map(string)` | Tags for the IAM role                |

## 📤 Outputs

| Name           | Description          |
|----------------|----------------------|
| irsa_role_arn  | IAM role ARN created |

## 🧩 Example Usage

```hcl
module "irsa" {
  source = "../eks-irsa"

  cluster_name         = "abc241-dev-eks"
  irsa_role_name       = "irsa-s3-access"
  namespace            = "default"
  service_account_name = "s3-reader"
  policy_arn           = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

  tags = {
    Env = "dev"
  }
}




---

### 📘 `eks-addons/README.md`

```markdown
# Terraform AWS EKS Add-ons Module

## 🚀 Features
- Installs or updates EKS add-ons (vpc-cni, kube-proxy, coredns, etc.)
- Supports custom versions and conflict resolution
- Optionally associate service account IAM roles

## 📥 Input Variables

| Name         | Type             | Description                              |
|--------------|------------------|------------------------------------------|
| cluster_name | `string`         | EKS cluster name                         |
| addons       | `map(object)`    | Add-on config (name, version, IRSA role) |

## 📤 Outputs

| Name             | Description                   |
|------------------|-------------------------------|
| installed_addons | List of installed add-on keys |

## 🧩 Example Usage

```hcl
module "eks_addons" {
  source       = "../eks-addons"
  cluster_name = "abc241-dev-eks"

  addons = {
    vpc-cni = {
      addon_version = "v1.14.1-eksbuild.1"
    }
    coredns = {
      addon_version = "v1.11.1-eksbuild.4"
    }
    kube-proxy = {
      addon_version = "v1.29.0-eksbuild.2"
    }
  }
}
