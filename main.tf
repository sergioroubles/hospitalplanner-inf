# Modules
module "bucket" {
    source = "./buckets"
}

module "lambdas" {
    source = "./lambdas"
    bucket_id = module.bucket.s3_bucket_backend_id
    restapi_id = module.apigateway.restapi_id
    PUBLIC_SUPABASE_ANON_KEY = var.PUBLIC_SUPABASE_ANON_KEY
    restapi_execution_arn = module.apigateway.restapi_execution_arn
}

module "apigateway" {
    source = "./apigateway"
    lambda_api_invoke_arn = module.lambdas.lambda_api_invoke_arn
    lambda_api_name = module.lambdas.lambda_api_name
    bucket_id = module.bucket.s3_bucket_backend_id
    authorizer_id = module.lambdas.authorizer_id
}

module "database" {
    source = "./database"
}