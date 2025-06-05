output "lambda_start_ec2_function_name" {
  description = "Name of the Lambda function that starts EC2 instances"
  value       = module.lambda_start_ec2.lambda_function_name
}

output "lambda_start_ec2_function_arn" {
  description = "ARN of the Lambda function that starts EC2 instances"
  value       = module.lambda_start_ec2.lambda_function_arn
}

output "lambda_stop_ec2_function_name" {
  description = "Name of the Lambda function that stops EC2 instances"
  value       = module.lambda_stop_ec2.lambda_function_name
}

output "lambda_stop_ec2_function_arn" {
  description = "ARN of the Lambda function that stops EC2 instances"
  value       = module.lambda_stop_ec2.lambda_function_arn
}

output "cloudwatch_start_rule_arn" {
  description = "ARN of the CloudWatch Events rule for starting EC2 instances"
  value       = module.cloudwatch_start_schedule.cloudwatch_event_rule_arn
}

output "cloudwatch_stop_rule_arn" {
  description = "ARN of the CloudWatch Events rule for stopping EC2 instances"
  value       = module.cloudwatch_stop_schedule.cloudwatch_event_rule_arn
}