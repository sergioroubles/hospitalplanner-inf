resource "aws_dynamodb_table" "shifts" {
  name         = "${var.environment}-shifts"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  range_key    = "datetime"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "datetime"
    type = "S"
  }

  attribute {
    name = "service_id"
    type = "S"
  }

  global_secondary_index {
    name            = "service_id-index"
    hash_key        = "service_id"
    range_key       = "datetime"
    projection_type = "ALL"
  }
}

