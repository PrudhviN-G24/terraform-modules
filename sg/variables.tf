variable "name" {
  description = "Name for the security group"
  type        = string
}

variable "description" {
  description = "Description for the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID where the SG will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups = optional(list(string), [])
    description = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups = optional(list(string), [])
    description = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
