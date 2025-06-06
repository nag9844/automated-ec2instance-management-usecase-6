# EC2 Instance Scheduler Architecture

## Overview

This document provides an overview of the EC2 Instance Scheduler architecture, which is designed to automatically start and stop EC2 instances based on company working hours (8:00 AM to 5:00 PM on weekdays).

## Architecture Diagram

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│  CloudWatch     │      │  Lambda         │      │  EC2 Instances  │
│  Events         │      │  Functions      │      │  (Tagged)       │
│                 │      │                 │      │                 │
│  ┌───────────┐  │      │  ┌───────────┐  │      │  ┌───────────┐  │
│  │ 8:00 AM   │──┼─────▶│  │Start EC2  │──┼─────▶│  │Instance 1 │  │
│  │ Schedule  │  │      │  │Instances  │  │      │  └───────────┘  │
│  └───────────┘  │      │  └───────────┘  │      │                 │
│                 │      │                 │      │  ┌───────────┐  │
│  ┌───────────┐  │      │  ┌───────────┐  │      │  │Instance 2 │  │
│  │ 5:00 PM   │──┼─────▶│  │Stop EC2   │──┼─────▶│  └───────────┘  │
│  │ Schedule  │  │      │  │Instances  │  │      │                 │
│  └───────────┘  │      │  └───────────┘  │      │  ┌───────────┐  │
│                 │      │                 │      │  │Instance 3 │  │
└─────────────────┘      └─────────────────┘      │  └───────────┘  │
                                                  │                 │
                                                  └─────────────────┘
```

## Components

### 1. CloudWatch Events

Two CloudWatch Event rules are configured:

- **Start Instances Rule**: Triggers at 8:00 AM (UTC) on weekdays (Monday to Friday)
- **Stop Instances Rule**: Triggers at 5:00 PM (UTC) on weekdays (Monday to Friday)

### 2. Lambda Functions

Two Lambda functions are deployed:

- **Start EC2 Instances**: Triggered by the 8:00 AM CloudWatch Event rule to start tagged EC2 instances
- **Stop EC2 Instances**: Triggered by the 5:00 PM CloudWatch Event rule to stop tagged EC2 instances

### 3. EC2 Instances

EC2 instances tagged with a specific key-value pair (default: `Name=true`) are managed by the scheduler. Only instances with this tag will be automatically started and stopped.

### 4. IAM Roles and Policies

IAM roles and policies are created to grant the Lambda functions the necessary permissions to:

- Describe EC2 instances
- Start EC2 instances
- Stop EC2 instances

## Workflow

1. At 8:00 AM on weekdays, the CloudWatch Event rule triggers the Start EC2 Instances Lambda function
2. The Lambda function queries for EC2 instances with the specified tag and in the "stopped" state
3. The Lambda function starts the identified instances
4. At 5:00 PM on weekdays, the CloudWatch Event rule triggers the Stop EC2 Instances Lambda function
5. The Lambda function queries for EC2 instances with the specified tag and in the "running" state
6. The Lambda function stops the identified instances

## Tagging Strategy

Instances are selected for automatic scheduling based on tags. The default configuration uses:

- **Tag Key**: "Name"
- **Tag Value**: "Demo Server"

To include an EC2 instance in the scheduling, tag it with `Name=Demo Server`.

## Customization

The solution can be customized by modifying the following variables:

- AWS Region
- Tag key and value for instance selection
- Schedule expressions for different working hours
- Environment name
- Project name