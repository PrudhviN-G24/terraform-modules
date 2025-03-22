variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.29"
}

variable "subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type    = list(string)
  default = []
}
variable "private_subnet_ids" {
  type    = list(string)
  default = []
}


variable "vpc_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

# Toggle Flags
variable "enable_node_group" {
  type    = bool
  default = true
}

variable "enable_fargate" {
  type    = bool
  default = false
}

# IAM Roles
# variable "cluster_role_arn" {
#   type = string
# }

# variable "node_role_arn" {
#   type    = string
#   default = null
# }

# variable "fargate_pod_execution_role_arn" {
#   type    = string
#   default = null
# }

# Node Group Configs
variable "node_group_name" {
  type    = string
  default = "eks-node-group"
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 3
}

variable "bootstrap_extra_args" {
  type    = string
  default = ""
}

# Fargate Selectors
variable "fargate_selectors" {
  type = list(object({
    namespace = string
    labels    = optional(map(string))
  }))
  default = []
}

# Add-ons
variable "addons" {
  type = map(object({
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
  }))
  default = {}
}
