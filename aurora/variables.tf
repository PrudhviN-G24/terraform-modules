variable "cluster_identifier" {
  type        = string
  description = "Aurora cluster identifier"
}

variable "engine" {
  type        = string
  description = "Aurora engine (aurora-mysql or aurora-postgresql)"
}

variable "engine_version" {
  type        = string
  description = "Aurora engine version"
}

variable "database_name" {
  type        = string
  description = "Initial database name"
}

variable "master_username" {
  type        = string
  description = "Master username"
}

variable "master_password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of SGs to attach"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for Aurora cluster"
}

variable "instance_class" {
  type        = string
  description = "Instance class for Aurora cluster instances"
}

variable "instance_count" {
  type        = number
  description = "Number of instances in the cluster"
  default     = 2
}

variable "storage_encrypted" {
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "tags" {
  type        = map(string)
  default     = {}
}
