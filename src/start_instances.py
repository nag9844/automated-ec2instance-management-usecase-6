import boto3
import os
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Get environment variables
TAG_KEY = os.environ.get('TAG_KEY', 'test')
TAG_VALUE = os.environ.get('TAG_VALUE', 'start-or-stop')
REGION = os.environ.get('REGION', 'ap-south-1')

def lambda_handler(event, context):
    # Initialize EC2 client
    ec2_client = boto3.client('ec2', region_name=REGION)
    
    # Find instances with the specified tag
    response = ec2_client.describe_instances(
        Filters=[
            {
                'Name': f'tag:{TAG_KEY}',
                'Values': [TAG_VALUE]
            },
            {
                'Name': 'instance-state-name',
                'Values': ['stopped']
            }
        ]
    )
    
    instances_to_start = []
    
    # Extract instance IDs from the response
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instances_to_start.append(instance['InstanceId'])
    
    # If there are instances to start
    if instances_to_start:
        logger.info(f"Starting instances: {instances_to_start}")
        
        # Start the instances
        start_response = ec2_client.start_instances(
            InstanceIds=instances_to_start
        )
        
        return {
            'statusCode': 200,
            'body': f"Started instances: {instances_to_start}"
        }
    else:
        logger.info("No instances to start")
        
        return {
            'statusCode': 200,
            'body': "No instances to start"
        }