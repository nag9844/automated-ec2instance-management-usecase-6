variable "name" {
  description = "Name of the CloudWatch Events rule"
  type        = string
}

variable "description" {
  description = "Description of the CloudWatch Events rule"
  type        = string
}

variable "schedule_expression" {
  description = "Schedule expression for the CloudWatch Events rule"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to be triggered"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to be triggered"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}