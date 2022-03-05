# Role for code codebuild

resource "aws_iam_role" "LambdaRole" {
  name = "LambdaRole"
  assume_role_policy = "${file(".\\iam\\LambdaAssumeRole.json")}"
  tags = {
    Name = "LambdaRole"
  }
}

output "aws_iam_role_LambdaRole_output" {
  value = aws_iam_role.LambdaRole.arn
}


resource "aws_iam_role_policy" "LambdaPolicy" {
  name = "LambdaPolicy"
  role = aws_iam_role.LambdaRole.id
  policy = "${file(".\\iam\\LambdaPolicy.json")}"

  depends_on = [
    aws_iam_role.LambdaRole
  ]
}