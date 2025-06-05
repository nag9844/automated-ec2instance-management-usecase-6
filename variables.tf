variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "ec2-scheduler"
}

variable "tag_key" {
  description = "Tag key to identify EC2 instances that should be managed by the scheduler"
  type        = string
  default     = "AutoStart"
}

variable "tag_value" {
  description = "Tag value to identify EC2 instances that should be managed by the scheduler"
  type        = string
  default     = "true"
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner       = "Operations"
    CostCenter  = "IT"
  }
}