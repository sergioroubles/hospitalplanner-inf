output "lambda_api_invoke_arn" {
  value = aws_lambda_function.api.invoke_arn
}

output "lambda_api_name" {
  value = aws_lambda_function.api.function_name
}

output "authorizer_id" {
  value = aws_api_gateway_authorizer.supabase.id
}
