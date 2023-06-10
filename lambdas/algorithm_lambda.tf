resource "aws_lambda_function" "algorithm" {
    function_name    = "lambda-algorithm-backend"
    s3_bucket        = var.bucket_id
    s3_key           = "algorithm/lambda_package.zip"
    runtime          = "python3.9"
    handler          = "src.main.handler"
    role             = aws_iam_role.lambda_backend.arn
}