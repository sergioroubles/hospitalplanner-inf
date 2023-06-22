resource "aws_s3_bucket" "backend" {
  bucket = "hospitalplanner-backend-${var.environment}"
  tags = {
    Name = "hospitalplanner-backend-${var.environment}"
  }
}
