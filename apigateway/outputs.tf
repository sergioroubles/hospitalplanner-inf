output "restapi_id" {
    description = "Rest APIGW id"
    value = aws_api_gateway_rest_api.hospitalplanner.id
}

output "restapi_execution_arn" {
    value = aws_api_gateway_rest_api.hospitalplanner.execution_arn
}