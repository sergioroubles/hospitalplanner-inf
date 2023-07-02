provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  default_tags {
    tags = {
      created-by  = "terraform"
      environment = var.environment
      project     = "hospitalplanner"
    }
  }

  endpoints {
    dynamodb = "http://localhost:4566"
    lambda   = "http://localhost:4566"
  }
}
