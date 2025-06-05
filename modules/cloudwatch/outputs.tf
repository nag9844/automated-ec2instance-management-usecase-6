output "cloudwatch_event_rule_id" {
  description = "ID of the CloudWatch Events rule"
  value       = aws_cloudwatch_event_rule.schedule.id
}

output "cloudwatch_event_rule_arn" {
  description = "ARN of the CloudWatch Events rule"
  value       = aws_cloudwatch_event_rule.schedule.arn
}

output "cloudwatch_event_target_id" {
  description = "ID of the CloudWatch Events target"
  value       = aws_cloudwatch_event_target.lambda_target.id
}