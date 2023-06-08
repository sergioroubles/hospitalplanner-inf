provider "aws" {
    region = var.aws_region
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY

    default_tags {
        tags = {
            created-by = "terraform"
        }
    } 
}

module "bucket" {
    source = "./buckets"
}

module "lambda" {
    source = "./lambda"
    bucket_id = module.bucket.s3_bucket_backend_id
}

module "apigateway" {
    source = "./apigateway"
    lambda_api_invoke_arn = module.lambda.lambda_api_invoke_arn
    lambda_api_name = module.lambda.lambda_api_name
}