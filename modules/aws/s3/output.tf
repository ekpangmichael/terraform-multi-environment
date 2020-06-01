
# Output variable definitions
output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.b.arn
}

output "id" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.b.id
}

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.b.website_endpoint
}