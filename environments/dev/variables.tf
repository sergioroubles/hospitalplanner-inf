variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "AWS_ACCESS_KEY" {
  description = "Access key for terraform user"
  type        = string
}

variable "AWS_SECRET_KEY" {
  description = "Secret key for terraform user"
  type        = string
}

variable "PUBLIC_SUPABASE_ANON_KEY" {
  description = "Public supabase anon key for the authenticator lambda."
  type        = string
}

variable "environment" {
  description = "Environment: dev | prod"
  type        = string
  default     = "dev"
}
