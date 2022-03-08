import json
import boto3
import os

s3 = boto3.resource('s3')

def lambda_handler(event, context):
    destination = os.getenv('destination')
    source = os.getenv('source')
    file_name = event['Records'][0]['s3']['object']['key']
    s3.meta.client.download_file(source, file_name, '/tmp/output.txt')
    # the file to be converted to 
    # json format
    filename = '/tmp/output.txt'
  
    # dictionary where the lines from
    # text will be stored
    dict1 = {}
  
    # creating dictionary
    with open(filename) as fh:
  
        for line in fh:
  
        # reads each line and trims of extra the spaces 
        # and gives only the valid words
            command, description = line.strip().split(None, 1)
  
            dict1[command] = description.strip()
  
    # creating json file

    out_file = open(f"/tmp/{file_name}.json", "w")
    json.dump(dict1, out_file, indent = 4, sort_keys = False)
    out_file.close()
    s3.meta.client.upload_file(f"/tmp/{file_name}.json", destination, f"{file_name}.json")
