terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
      CreatedBy   = "EC2-Scheduler"
    }
  }
}

# EC2 Instance Start Lambda Module
module "lambda_start_ec2" {
  source        = "./modules/lambda"
  function_name = "${var.project_name}-start-ec2-instances"
  description   = "Lambda function to start EC2 instances during working hours"
  handler       = "start_instances.lambda_handler"
  runtime       = "python3.10"
  timeout       = 60
  environment_variables = {
    TAG_KEY   = var.tag_key
    TAG_VALUE = var.tag_value
    REGION    = var.aws_region
  }
  lambda_code_path = "${path.module}/src/start_instances.py"
  policy_actions   = ["ec2:DescribeInstances", "ec2:StartInstances"]
  tags             = var.tags
}

# EC2 Instance Stop Lambda Module
module "lambda_stop_ec2" {
  source        = "./modules/lambda"
  function_name = "${var.project_name}-stop-ec2-instances"
  description   = "Lambda function to stop EC2 instances outside working hours"
  handler       = "stop_instances.lambda_handler"
  runtime       = "python3.10"
  timeout       = 60
  environment_variables = {
    TAG_KEY   = var.tag_key
    TAG_VALUE = var.tag_value
    REGION    = var.aws_region
  }
  lambda_code_path = "${path.module}/src/stop_instances.py"
  policy_actions   = ["ec2:DescribeInstances", "ec2:StopInstances"]
  tags             = var.tags
}

# CloudWatch Events for scheduling
module "cloudwatch_start_schedule" {
  source               = "./modules/cloudwatch"
  name                 = "${var.project_name}-start-instances-schedule"
  description          = "Triggers the Lambda function to start EC2 instances at 8:00 AM on weekdays"
  schedule_expression  = "cron(50 10 ? * MON-FRI *)" # 8:00 AM Monday-Friday
  # schedule_expression  = "cron(1 * * * *)"
  lambda_function_arn  = module.lambda_start_ec2.lambda_function_arn
  lambda_function_name = module.lambda_start_ec2.lambda_function_name
  tags                 = var.tags
}

module "cloudwatch_stop_schedule" {
  source               = "./modules/cloudwatch"
  name                 = "${var.project_name}-stop-instances-schedule"
  description          = "Triggers the Lambda function to stop EC2 instances at 5:00 PM on weekdays"
  schedule_expression  = "cron(55 10 ? * MON-FRI *)" # 5:00 PM Monday-Friday
  # schedule_expression  = "cron(1 * * * *)"
  lambda_function_arn  = module.lambda_stop_ec2.lambda_function_arn
  lambda_function_name = module.lambda_stop_ec2.lambda_function_name
  tags                 = var.tags
}