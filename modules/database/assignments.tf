resource "aws_dynamodb_table" "assignments" {
    name           = "assignments${local.env_suffix}"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "id"
    range_key       = "plan_id"

    attribute {
        name = "id"
        type = "S"
    }

    attribute {
        name = "plan_id"
        type = "S"
    }

    attribute {
        name = "worker_id"
        type = "S"
    }

    global_secondary_index {
        name = "worker_id-index"
        hash_key = "worker_id"
        range_key = "plan_id"
        projection_type = "ALL"
    }

    global_secondary_index {
        name = "plan_id-index"
        hash_key = "plan_id"
        projection_type = "ALL"
    }
}