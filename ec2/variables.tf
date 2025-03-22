variable "name" {
  description = "Name tag for the instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to launch (Linux, Windows, custom)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance into"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to assign a public IP"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "List of existing security group IDs"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "SSH key name (optional)"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "volume_size" {
  description = "Root EBS volume size (GB)"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "EBS volume type"
  type        = string
  default     = "gp3"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name (optional)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the instance"
  type        = map(string)
  default     = {}
}
