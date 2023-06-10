variable "bucket_id" {
    description = "ID of the bucket to store the lambda function"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}