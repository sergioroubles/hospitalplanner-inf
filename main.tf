# Modules
module "bucket" {
    source = "./buckets"
}

module "lambdas" {
    source = "./lambdas"
    bucket_id = module.bucket.s3_bucket_backend_id
}

module "apigateway" {
    source = "./apigateway"
    lambda_api_invoke_arn = module.lambdas.lambda_api_invoke_arn
    lambda_api_name = module.lambdas.lambda_api_name
    bucket_id = module.bucket.s3_bucket_backend_id
    PUBLIC_SUPABASE_ANON_KEY = var.PUBLIC_SUPABASE_ANON_KEY
}

module "database" {
    source = "./database"
}