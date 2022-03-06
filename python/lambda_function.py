import json
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    destination = os.getenv('destination')
    source = os.getenv('source')
    file_name = event['Records'][0]['s3']['object']['key']
    dict1 = {}
    
    with open(file_name) as fh:
  
        for line in fh:

            command, description = line.strip().split(None, 1) 
            dict1[command] = description.strip()
    
    file_converted_name = "{file_name}_converted"
    out_file = open("{file_converted_name}.json", "w")
    json.dump(dict1, out_file, indent = 4, sort_keys = False)
    out_file.close()

    copy_source_object = {'Bucket': source, 'Key': file_converted_name}
    s3.copy_object(CopySource=copy_source_object, Bucket=destination, Key=file_converted_name)