output "s3_bucket_backend_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.backend.id
}

output "s3_bucket_backend_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.backend.arn
}
