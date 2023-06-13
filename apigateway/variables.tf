variable "lambda_api_invoke_arn" {
    description = "Invoke ARN of the lambda that will handle the requests"
    type = string
}

variable "lambda_api_name" {
    description = "Function name of the lambda that will handle the requests"
    type = string
}

variable "bucket_id" {
    description = "Bucket id for the auth lambda"
    type = string
}

variable "authorizer_id" {
    type = string
}