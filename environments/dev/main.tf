# Main definition
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "hospitalplanner-terraform-backend"
    key    = "dev/terraform.tfstate"
    region = "eu-west-2"
    encrypt        = true
  }
}

# Modules
module "bucket" {
    source = "../../modules/buckets"
}

module "lambdas" {
    source = "../../modules/lambdas"
    bucket_id = module.bucket.s3_bucket_backend_id
    restapi_id = module.apigateway.restapi_id
    PUBLIC_SUPABASE_ANON_KEY = var.PUBLIC_SUPABASE_ANON_KEY
    restapi_execution_arn = module.apigateway.restapi_execution_arn
}

module "apigateway" {
    source = "../../modules/apigateway"
    lambda_api_invoke_arn = module.lambdas.lambda_api_invoke_arn
    lambda_api_name = module.lambdas.lambda_api_name
    bucket_id = module.bucket.s3_bucket_backend_id
    authorizer_id = module.lambdas.authorizer_id
}

module "database" {
    source = "../../modules/database"
}

