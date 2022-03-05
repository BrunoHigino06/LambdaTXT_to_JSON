module "iam" {
  source = ".\\iam\\"
  providers = {
    aws = aws.us
  }
}

module "infrastructure" {
  source = ".\\infrastructure\\"
  providers = {
    aws = aws.us
  }
  aws_lambda_function_S3ToS3_role_var = module.iam.aws_iam_role_LambdaRole_output
  
  
  depends_on = [
    module.iam
  ]
}