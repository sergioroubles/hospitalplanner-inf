resource "aws_dynamodb_table" "plans" {
  name           = "plans${local.env_suffix}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key       = "name"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

}