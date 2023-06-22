resource "aws_dynamodb_table" "shifts" {
  name         = "shifts${local.env_suffix}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  range_key    = "datetime"

  attribute {
    name = "id"
    type = "S"
  }

  # attribute {
  #     name = "name"
  #     type = "S"
  # }

  attribute {
    name = "datetime"
    type = "S"
  }

  attribute {
    name = "plan_id"
    type = "S"
  }

  global_secondary_index {
    name            = "plan_id-index"
    hash_key        = "plan_id"
    range_key       = "datetime"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table_item" "shifts_items" {
  count      = length(local.items["shifts"])
  table_name = aws_dynamodb_table.shifts.name
  hash_key   = "id"
  item       = jsonencode(local.items["shifts"][count.index])
}
