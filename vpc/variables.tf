variable "environment" {
  description = "Environment name (e.g., abc241-dev, abc242-uat)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway (true/false)"
  type        = bool
  default     = false
}

variable "enable_s3_gateway_endpoint" {
  description = "Enable S3 Gateway Endpoint (true/false)"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Enable DNS resolution in VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
