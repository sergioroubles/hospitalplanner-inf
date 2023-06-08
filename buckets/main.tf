resource "aws_s3_bucket" "backend" {
    bucket = "hospitalplanner-backend"
    tags = {
        Name = "hospitalplanner-backend"
    }
}