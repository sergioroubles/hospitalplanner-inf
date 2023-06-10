resource "aws_dynamodb_table" "workers" {
  name           = "workers"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  global_secondary_index {
    name = "name-index"
    hash_key = "name"
    range_key = "id"
    projection_type = "ALL"
  }
}