resource "aws_lambda_function" "algorithm" {
    function_name    = "lambda-algorithm-backend-${var.environment}"
    s3_bucket        = var.bucket_id
    s3_key           = "algorithm/lambda_package.zip"
    runtime          = "python3.9"
    handler          = "lambda_function.lambda_handler"
    role             = aws_iam_role.lambda_backend.arn
    timeout = 6
    layers = ["arn:aws:lambda:eu-west-2:336392948345:layer:AWSSDKPandas-Python39:7"]
}