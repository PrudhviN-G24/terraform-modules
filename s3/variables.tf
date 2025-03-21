variable "bucket_name" {
  description = "Base name for the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for SSE-KMS encryption (optional)"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Force destroy bucket on delete"
  type        = bool
  default     = false
}

variable "lifecycle_rule" {
  description = "Enable lifecycle rule to expire objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
