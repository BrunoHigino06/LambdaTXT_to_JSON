resource "aws_lambda_function" "S3ToS3" {
  filename      = "./python/s3tos3.zip"
  function_name = "S3ToS3"
  role          = var.aws_lambda_function_S3ToS3_role_var
  handler       = "index.test"
  source_code_hash = filebase64sha256("./python/s3tos3.zip")

  runtime = "python3.8"

  environment {
    variables = {
      name = "S3ToS3"
    }
  }
}


resource "aws_s3_bucket" "SourceBucket" {
  name = "SourceBucket${timestamp()}"
  
  tags = {
    "name" = "SourceBucket"
  }

}

resource "aws_s3_bucket_acl" "SourceBucketACL" {
  bucket = aws_s3_bucket.SourceBucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "DestBucket" {
  name = "SourceBucket${timestamp()}"
  
  tags = {
    "name" = "DestBucket"
  }

}

resource "aws_s3_bucket_acl" "DestBucketACL" {
  bucket = aws_s3_bucket.DestBucket.id
  acl    = "private"
}