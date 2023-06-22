variable "bucket_id" {
  description = "ID of the bucket to store the lambda function"
}

variable "restapi_id" {
  description = "Rest APIGW id"
}


variable "PUBLIC_SUPABASE_ANON_KEY" {
  description = "Public supabase anon key for the authenticator lambda."
  type        = string
}

variable "restapi_execution_arn" {
  type = string
}

variable "environment" {
  description = "Environment of deployment: dev | prod."
  type        = string
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
