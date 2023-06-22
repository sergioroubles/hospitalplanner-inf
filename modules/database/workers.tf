resource "aws_dynamodb_table" "workers" {
  name         = "workers${local.env_suffix}"
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

  global_secondary_index {
    name            = "name-index"
    hash_key        = "name"
    range_key       = "id"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table_item" "workers_items" {
  count      = length(local.items["workers"])
  table_name = aws_dynamodb_table.workers.name
  hash_key   = "id"
  item       = jsonencode(local.items["workers"][count.index])
}
