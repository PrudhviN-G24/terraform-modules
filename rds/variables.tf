variable "identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine (mysql, postgres, etc.)"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance class (e.g., db.t3.micro)"
  type        = string
}

variable "allocated_storage" {
  description = "Storage in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Type of storage (standard, gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "username" {
  description = "Master DB username"
  type        = string
}

variable "password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security groups to associate"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for subnet group"
  type        = list(string)
}

variable "multi_az" {
  description = "Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Should the DB be publicly accessible"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
