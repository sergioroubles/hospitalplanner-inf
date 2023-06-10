resource "aws_lambda_function" "api" {
    function_name    = "lambda-api-backend"
    s3_bucket        = var.bucket_id
    s3_key           = "api/lambda_package.zip"
    runtime          = "python3.9"
    handler          = "src.main.handler"
    role             = aws_iam_role.lambda_backend.arn
}