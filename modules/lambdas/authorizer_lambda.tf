# AUTHORIZER
resource "aws_lambda_function" "auth" {
  function_name = "lambda-auth-backend-${var.environment}"
  s3_bucket     = var.bucket_id
  s3_key        = "authenticator/lambda_package.zip"
  runtime       = "python3.9"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.lambda_backend.arn

  environment {
    variables = {
      PUBLIC_SUPABASE_URL      = "https://mxemncnouldyyxhohrax.supabase.co"
      PUBLIC_SUPABASE_ANON_KEY = "${var.PUBLIC_SUPABASE_ANON_KEY}"
      ENVIRONMENT = "${var.environment}"
    }
  }
}

resource "aws_lambda_permission" "authgateway" {
  statement_id  = "AllowAPIGatewayInvoke-${var.environment}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.auth.function_name
  principal     = "apigateway.amazonaws.com"

  # # The /*/* portion grants access from any method on any resource
  # # within the API Gateway "REST API".
  source_arn = "${var.restapi_execution_arn}/*/*"
}

resource "aws_api_gateway_authorizer" "supabase" {
  name                             = "supabase"
  rest_api_id                      = var.restapi_id
  authorizer_uri                   = aws_lambda_function.auth.invoke_arn
  authorizer_credentials           = aws_iam_role.invocation_role.arn
  identity_source                  = "method.request.header.authorizationToken"
  authorizer_result_ttl_in_seconds = 0
}



resource "aws_iam_role" "invocation_role" {
  name = "api_gateway_auth_invocation-${var.environment}"
  path = "/"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "apigateway.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}


resource "aws_iam_role_policy" "invocation_policy" {
  name = "default"
  role = aws_iam_role.invocation_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${aws_lambda_function.auth.arn}"
    }
  ]
}
EOF
}
