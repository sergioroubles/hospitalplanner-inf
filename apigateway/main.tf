resource "aws_api_gateway_rest_api" "hospitalplanner" {
  name        = "hospitalplanner"
  description = "Hospital Planner API Gateway"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.hospitalplanner.id
  parent_id   = aws_api_gateway_rest_api.hospitalplanner.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.hospitalplanner.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.supabase.id
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.hospitalplanner.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_api_invoke_arn
}

resource "aws_api_gateway_deployment" "hospitalplanner" {
  depends_on = [
    aws_api_gateway_integration.lambda,
  ]

  rest_api_id = aws_api_gateway_rest_api.hospitalplanner.id
  stage_name  = "test"
}

resource "aws_lambda_permission" "apigateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_api_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.hospitalplanner.execution_arn}/*/*"
}



# AUTHORIZER
resource "aws_lambda_function" "auth" {
    function_name    = "lambda-auth-backend"
    s3_bucket        = var.bucket_id
    s3_key           = "authenticator/lambda_package.zip"
    runtime          = "python3.9"
    handler          = "main.lambda_handler"
    role             = "arn:aws:iam::568433399472:role/service-role/supabase-auth-role-o87ww6k6"

    environment {
      variables = {
        PUBLIC_SUPABASE_URL = "https://mxemncnouldyyxhohrax.supabase.co"
        PUBLIC_SUPABASE_ANON_KEY = "${var.PUBLIC_SUPABASE_ANON_KEY}"
      }
    }
}

resource "aws_api_gateway_authorizer" "supabase" {
  name                   = "supabase"
  rest_api_id            = aws_api_gateway_rest_api.hospitalplanner.id
  authorizer_uri         = aws_lambda_function.auth.invoke_arn
  authorizer_credentials = "arn:aws:iam::568433399472:role/service-role/supabase-auth-role-o87ww6k6" #TODO CHANGE HARCODED ARN TO CICD
  identity_source = "method.request.header.accessToken"
  authorizer_result_ttl_in_seconds = 0
}

