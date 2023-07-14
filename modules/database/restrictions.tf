resource "aws_dynamodb_table" "restrictions" {
    name           = "${var.environment}-restrictions"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "id"

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

    global_secondary_index {
        name = "service_id-index"
        hash_key = "service_id"
        range_key = "datetime"
        projection_type = "ALL"
    }
}
