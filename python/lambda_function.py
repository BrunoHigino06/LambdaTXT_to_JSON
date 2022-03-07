import json
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    destination = os.getenv('destination')
    source = os.getenv('source')
    file_name = event['Records'][0]['s3']['object']['key']
    file_object = s3.get_object(Bucket=source, Key=file_name)
  
# dictionary where the lines from
# text will be stored
    dict1 = {}
  
# creating dictionary
    with open(file_object) as fh:
  
        for line in fh:
  
        # reads each line and trims of extra the spaces 
        # and gives only the valid words
            command, description = line.strip().split(None, 1)
  
            dict1[command] = description.strip()
  
# creating json file
# the JSON file is named as test1
    out_file = open("test1.json", "w")
    json.dump(dict1, out_file, indent = 4, sort_keys = False)
    out_file.close()
