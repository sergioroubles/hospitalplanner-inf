# Modules
module "bucket" {
  source      = "../../modules/buckets"
  environment = var.environment
}

module "lambdas" {
  source                   = "../../modules/lambdas"
  bucket_id                = module.bucket.s3_bucket_backend_id
  restapi_id               = module.apigateway.restapi_id
  PUBLIC_SUPABASE_ANON_KEY = var.PUBLIC_SUPABASE_ANON_KEY
  restapi_execution_arn    = module.apigateway.restapi_execution_arn
  environment              = var.environment
}

module "apigateway" {
  source                = "../../modules/apigateway"
  lambda_api_invoke_arn = module.lambdas.lambda_api_invoke_arn
  lambda_api_name       = module.lambdas.lambda_api_name
  bucket_id             = module.bucket.s3_bucket_backend_id
  authorizer_id         = module.lambdas.authorizer_id
  environment           = var.environment
}

module "database" {
  source      = "../../modules/database"
  environment = var.environment
}

