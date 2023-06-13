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

resource "aws_lambda_permission" "authgateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.auth.function_name
  principal     = "apigateway.amazonaws.com"

  # # The /*/* portion grants access from any method on any resource
  # # within the API Gateway "REST API".
  # source_arn = "${aws_api_gateway_rest_api.hospitalplanner.execution_arn}/*/*"
}

resource "aws_api_gateway_authorizer" "supabase" {
  name                   = "supabase"
  rest_api_id            = aws_api_gateway_rest_api.hospitalplanner.id
  authorizer_uri         = aws_lambda_function.auth.invoke_arn
  identity_source = "method.request.header.accessToken"
  authorizer_result_ttl_in_seconds = 0
}
