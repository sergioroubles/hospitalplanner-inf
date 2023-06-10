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
