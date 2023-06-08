resource "aws_lambda_function" "api" {
    function_name    = "lambda-api-backend"
    s3_bucket        = var.bucket_id
    s3_key           = "api/lambda_package.zip"
    runtime          = "python3.9"
    handler          = "src.main.handler"
    role             = aws_iam_role.lambda_backend.arn
}

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_backend" {
    name               = "backend_lambda_role"
    assume_role_policy = "${data.aws_iam_policy_document.AWSLambdaTrustPolicy.json}"
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
    for_each = toset([
        "arn:aws:iam::aws:policy/AmazonS3FullAccess", 
        "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
    ])
    role       = aws_iam_role.lambda_backend.name
    policy_arn = each.value
}
