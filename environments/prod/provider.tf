provider "aws" {
    region = var.aws_region
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY

    default_tags {
        tags = {
            created-by = "terraform"
            environment = var.environment
            project = "hospitalplanner"
        }
    } 
}
