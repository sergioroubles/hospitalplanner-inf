# Get AWS lambda trust policy
data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Creat lambda role, allow lambda to assume this role
resource "aws_iam_role" "lambda_backend" {
  name               = "backend_lambda_role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
}

# Attach policies to role to access S3 and DynamoDB
resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ])
  role       = aws_iam_role.lambda_backend.name
  policy_arn = each.value
}

data "aws_iam_policy_document" "lambda_log_and_invoke_policy" {

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]

  }

  statement {
    effect = "Allow"

    actions = ["lambda:*"]

    resources = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:*"]
  }
}

resource "aws_iam_role_policy" "api_lambda_role_policy" {
  name   = "api-lambda-role-policy-${var.environment}"
  role   = aws_iam_role.lambda_backend.id
  policy = data.aws_iam_policy_document.lambda_log_and_invoke_policy.json
}
