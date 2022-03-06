import json
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):

    source = s3.Bucket(os.getenv('source'))
    destination = s3.Bucket(os.getenv('destination'))

    file_name = event['Records'][0][source]['object']['key']
    copy_source_object = {'Bucket': source, 'Key': file_name}
    s3.copy_object(CopySource=copy_source_object, Bucket=destination, Key=file_name)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Execution sucessed')
    }