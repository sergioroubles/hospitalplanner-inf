resource "aws_lambda_function" "api" {
  function_name = "lambda-api-backend-${var.environment}"
  s3_bucket     = var.bucket_id
  s3_key        = "api/lambda_package.zip"
  runtime       = "python3.9"
  handler       = "src.main.handler"
  role          = aws_iam_role.lambda_backend.arn
  timeout       = 10
  environment {
    variables = {
      ENVIRONMENT = "${var.environment}"
    }
  }
}
