locals {
  env_suffix = var.environment == "prod"? "-prod" : "-dev"
}