import boto3
import os
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Get environment variables
TAG_KEY = os.environ.get('TAG_KEY', 'Name')
TAG_VALUE = os.environ.get('TAG_VALUE', 'Demo Server')
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
                'Values': ['running']
            }
        ]
    )
    
    instances_to_stop = []
    
    # Extract instance IDs from the response
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instances_to_stop.append(instance['InstanceId'])
    
    # If there are instances to stop
    if instances_to_stop:
        logger.info(f"Stopping instances: {instances_to_stop}")
        
        # Stop the instances
        stop_response = ec2_client.stop_instances(
            InstanceIds=instances_to_stop
        )
        
        return {
            'statusCode': 200,
            'body': f"Stopped instances: {instances_to_stop}"
        }
    else:
        logger.info("No instances to stop")
        
        return {
            'statusCode': 200,
            'body': "No instances to stop"
        }