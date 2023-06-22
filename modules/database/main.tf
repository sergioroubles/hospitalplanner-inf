locals {
  env_suffix = var.environment == "prod"? "-prod" : "-dev"
  items = {
    "workers": jsondecode(file("${path.module}/mock-data/serialized-workers.json"))
    "shifts": jsondecode(file("${path.module}/mock-data/serialized-shifts.json"))
    "restrictions": jsondecode(file("${path.module}/mock-data/serialized-restrictions.json"))
    "shifts": jsondecode(file("${path.module}/mock-data/serialized-shifts.json"))
  }
}