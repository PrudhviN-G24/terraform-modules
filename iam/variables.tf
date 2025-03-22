variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "Trust policy for assuming the role"
  type        = string
}

variable "inline_policies" {
  description = "Map of inline policy names to policy JSON"
  type        = map(string)
  default     = {}
}

variable "managed_policy_arns" {
  description = "List of AWS managed or customer-managed policy ARNs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the IAM role"
  type        = map(string)
  default     = {}
}
