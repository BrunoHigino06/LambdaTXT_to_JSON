# Lambda Function

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

# S3 source and destination

resource "aws_s3_bucket" "SourceBucket" {
  bucket = "sourcebucket${formatdate("YYYYMMDDhhmmss", timestamp())}"
  
  tags = {
    "name" = "SourceBucket"
  }

}

resource "aws_s3_bucket_acl" "SourceBucketACL" {
  bucket = aws_s3_bucket.SourceBucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "DestBucket" {
  bucket = "destbucket${formatdate("YYYYMMDDhhmmss", timestamp())}"
  
  tags = {
    "name" = "DestBucket"
  }

}

resource "aws_s3_bucket_acl" "DestBucketACL" {
  bucket = aws_s3_bucket.DestBucket.id
  acl    = "private"
}

# Adding S3 bucket as trigger to my lambda and giving the permissions
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.SourceBucket.bucket
  lambda_function {
    lambda_function_arn = aws_lambda_function.S3ToS3.arn
    events              = ["s3:ObjectCreated:*"]

  }
}
resource "aws_lambda_permission" "LambdaS3Acess" {
  statement_id  = "LambdaS3Acess"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.S3ToS3.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.SourceBucket.id}"
}