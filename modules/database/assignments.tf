resource "aws_dynamodb_table" "assignments" {
  name         = "${var.environment}-assignments"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  range_key    = "service_id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "service_id"
    type = "S"
  }

  attribute {
    name = "worker_id"
    type = "S"
  }

  global_secondary_index {
    name            = "worker_id-index"
    hash_key        = "worker_id"
    range_key       = "service_id"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "service_id-index"
    hash_key        = "service_id"
    projection_type = "ALL"
  }
}
