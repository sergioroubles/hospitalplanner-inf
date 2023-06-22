resource "aws_dynamodb_table" "restrictions" {
    name           = "restrictions${local.env_suffix}"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "id"
    range_key       = "datetime"

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
        name = "worker_id"
        type = "S"
    }

    global_secondary_index {
        name = "worker_id-index"
        hash_key = "worker_id"
        range_key = "datetime"
        projection_type = "ALL"
    }
}

resource "aws_dynamodb_table_item" "restrictions_items" {
  count = length(local.items["restrictions"])
  table_name = aws_dynamodb_table.restrictions.name
  hash_key = "id"
  item = jsonencode(local.items["restrictions"][count.index])
}