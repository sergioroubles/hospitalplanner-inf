resource "aws_dynamodb_table" "services" {
  name         = "${var.environment}-services"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
