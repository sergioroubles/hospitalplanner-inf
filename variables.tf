variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "eu-west-2"
}

variable AWS_ACCESS_KEY {
    description = "Access key for terraform user"
    type        = string
}

variable AWS_SECRET_KEY {
    description = "Seccret key for terraform user"
    type        = string
}