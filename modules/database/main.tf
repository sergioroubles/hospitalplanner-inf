locals {
  env_suffix = var.environment == "prod"? "" : "-dev"
}