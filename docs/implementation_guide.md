# EC2 Instance Scheduler Implementation Guide

This guide provides detailed information on implementing and using the EC2 Instance Scheduler.

## Prerequisites

- AWS Account
- Terraform v1.0.0 or higher
- AWS CLI configured with appropriate permissions
- GitHub account (for CI/CD pipeline)

## Deployment Options

### Option 1: Manual Terraform Deployment

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd ec2-scheduler
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Customize variables (optional):
   ```bash
   # Edit variables.tf or create a terraform.tfvars file
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

6. Confirm the deployment:
   ```bash
   terraform output
   ```

### Option 2: Automated Deployment with GitHub Actions

1. Fork the repository to your GitHub account
2. Configure AWS credentials as GitHub secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION`
3. Push changes to the main branch to trigger the workflow
4. Monitor the workflow execution in the Actions tab

## Tagging EC2 Instances

To include EC2 instances in the scheduling:

1. Select the EC2 instance in the AWS Management Console
2. Click on "Tags" tab
3. Add a new tag with:
   - Key: `AutoStart` (or the value specified in `var.tag_key`)
   - Value: `true` (or the value specified in `var.tag_value`)

Alternatively, add tags using the AWS CLI:
```bash
aws ec2 create-tags --resources i-1234567890abcdef0 --tags Key=AutoStart,Value=true
```

## Customizing Working Hours

To change the working hours:

1. Edit the `schedule_expression` parameter in the CloudWatch module calls in `main.tf`:
   ```hcl
   # To change start time from 8:00 AM to 9:00 AM:
   schedule_expression = "cron(0 9 ? * MON-FRI *)"
   
   # To change stop time from 5:00 PM to 6:00 PM:
   schedule_expression = "cron(0 18 ? * MON-FRI *)"
   ```

2. Apply the changes:
   ```bash
   terraform apply
   ```

## Monitoring and Troubleshooting

### CloudWatch Logs

Each Lambda function logs its activity to CloudWatch Logs. To view the logs:

1. Open the AWS Management Console
2. Navigate to CloudWatch > Log groups
3. Look for `/aws/lambda/<function-name>` log groups

### Common Issues

#### Instances not starting/stopping

1. Verify that the instances have the correct tags
2. Check Lambda function permissions
3. Review CloudWatch Logs for error messages
4. Ensure that the Lambda function timeout is sufficient

#### Lambda function failures

1. Check IAM permissions
2. Verify that the Python code is correct
3. Review CloudWatch Logs for error messages

## Maintenance

### Updating the Solution

To update the solution:

1. Pull the latest changes from the repository
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Apply the changes:
   ```bash
   terraform apply
   ```

### Removing the Solution

To remove the solution:

1. Run:
   ```bash
   terraform destroy
   ```
2. Confirm the destruction when prompted

## Best Practices

1. **Use Remote State**: Store Terraform state in an S3 bucket with DynamoDB locking
2. **Enable Versioning**: Use Git for version control and tag releases
3. **Test Changes**: Always run `terraform plan` before applying changes
4. **Monitor Costs**: Regularly review AWS costs and optimize as needed
5. **Implement Least Privilege**: Use IAM roles with minimal permissions
6. **Document Everything**: Keep documentation up-to-date