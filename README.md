# EC2 Instance Scheduler for Company Working Hours

This project provides a serverless solution for automatically starting and stopping EC2 instances based on company working hours using AWS Lambda and CloudWatch Events.

## Overview

Many companies don't need their EC2 instances running 24/7. This solution automates the process of starting instances at the beginning of the workday (8:00 AM) and stopping them at the end of the workday (5:00 PM), helping to optimize costs while ensuring resources are available when needed.

## Architecture

The solution uses the following AWS services:

- **AWS Lambda**: Executes the code to start and stop EC2 instances
- **Amazon CloudWatch Events**: Schedules Lambda functions based on cron expressions
- **AWS IAM**: Manages permissions for Lambda functions
- **Amazon EC2**: The target instances to be managed

For a detailed architecture explanation, see [Architecture Document](docs/architecture.md).

## Features

- Fully serverless architecture with minimal operational overhead
- Tag-based instance targeting (only manages instances with specific tags)
- Configurable scheduling with CloudWatch Events
- Secure IAM roles with least privilege permissions
- Comprehensive logging for monitoring and troubleshooting
- Infrastructure as Code (IaC) with Terraform for consistent deployments
- CI/CD pipeline with GitHub Actions

## Deployment

The solution can be deployed using Terraform:

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply
```

For detailed deployment instructions, see the [Implementation Guide](docs/implementation_guide.md).

## Usage

### Tagging Instances

Only instances with a specific tag will be managed by the scheduler. By default, instances need to be tagged with:

- Key: `AutoStart`
- Value: `true`

### Customization

The solution can be customized by modifying the following variables:

- AWS region
- Tag key and value
- Schedule expressions
- Environment name
- Project name

## GitHub Actions CI/CD

The repository includes a GitHub Actions workflow for CI/CD:

- Runs on push to main branch and pull requests
- Validates Terraform configuration
- Performs security scanning with tfsec and Checkov
- Creates a plan and comments on pull requests
- Applies changes when merged to main

## Documentation

- [Architecture Document](docs/architecture.md): Detailed architecture explanation
- [Implementation Guide](docs/implementation_guide.md): Step-by-step implementation instructions

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.