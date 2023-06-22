resource "aws_dynamodb_table" "services" {
  name           = "services${local.env_suffix}"
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

resource "aws_dynamodb_table_item" "services_items" {
  count = length(local.items["services"])
  table_name = aws_dynamodb_table.services.name
  hash_key = "id"
  item = jsonencode(local.items["services"][count.index])
}