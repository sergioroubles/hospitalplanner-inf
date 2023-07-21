resource "aws_dynamodb_table" "workers" {
  name         = "${var.environment}-workers"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }
  attribute {
    name = "service_id"
    type = "S"
  }

  global_secondary_index {
    name            = "service_id-index"
    hash_key        = "service_id"
    range_key       = "name"
    projection_type = "ALL"
  }
}
