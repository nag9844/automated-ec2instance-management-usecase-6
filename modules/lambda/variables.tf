variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "description" {
  description = "Description of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Handler for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime for the Lambda function"
  type        = string
  default     = "python3.10"
}

variable "timeout" {
  description = "Timeout for the Lambda function in seconds"
  type        = number
  default     = 60
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "lambda_code_path" {
  description = "Path to the Lambda function code"
  type        = string
}

variable "policy_actions" {
  description = "List of IAM policy actions for the Lambda function"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}