resource "aws_s3_bucket" "backend" {
  bucket = "hospitalplanner-backend-${var.environment}"
  tags = {
    Name = "hospitalplanner-backend-${var.environment}"
  }
}

locals {
  lambda_zips_dir = "../../helpers/localstack/lambda_zips"
}
resource "aws_s3_object" "algorithm_lambda_zip" {
  count = var.environment == "local"? 1 : 0
  bucket = aws_s3_bucket.backend.bucket
  key    = "/algorithm/lambda_package.zip"
  source = "${local.lambda_zips_dir}/algorithm/lambda_package.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${local.lambda_zips_dir}/algorithm/lambda_package.zip")
}

resource "aws_s3_object" "api_lambda_zip" {
  count = var.environment == "local"? 1 : 0
  bucket = aws_s3_bucket.backend.bucket
  key    = "/api/lambda_package.zip"
  source = "${local.lambda_zips_dir}/api/lambda_package.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${local.lambda_zips_dir}/api/lambda_package.zip")
}

resource "aws_s3_object" "authenticator_lambda_zip" {
  count = var.environment == "local"? 1 : 0
  bucket = aws_s3_bucket.backend.bucket
  key    = "/authenticator/lambda_package.zip"
  source = "${local.lambda_zips_dir}/authenticator/lambda_package.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${local.lambda_zips_dir}/authenticator/lambda_package.zip")
}