import json
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    destination = os.getenv('destination')
    source = os.getenv('source')
    file_name = event['Records'][0]['s3']['object']['key']
    copy_source_object = {'Bucket': source, 'Key': file_name}
    s3.copy_object(CopySource=copy_source_object, Bucket=destination, Key=file_name)