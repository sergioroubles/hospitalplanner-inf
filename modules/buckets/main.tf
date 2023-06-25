resource "aws_s3_bucket" "backend" {
  bucket = "hospitalplanner-backend-${var.environment}"
  tags = {
    Name = "hospitalplanner-backend-${var.environment}"
  }
}

resource "aws_s3_object" "algorithm_lambda_zip" {
  count = var.environment == "local"? 1 : 0
  bucket = aws_s3_bucket.backend.bucket
  key    = "/algorithm/lambda_package.zip"
  source = "../../environments/local/lambda_zips/algorithm/lambda_package.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../../environments/local/lambda_zips/algorithm/lambda_package.zip")
}

resource "aws_s3_object" "api_lambda_zip" {
  count = var.environment == "local"? 1 : 0
  bucket = aws_s3_bucket.backend.bucket
  key    = "/api/lambda_package.zip"
  source = "../../environments/local/lambda_zips/api/lambda_package.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../../environments/local/lambda_zips/api/lambda_package.zip")
}
