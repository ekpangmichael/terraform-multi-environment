output "aws_acm_certificate_arn" {
  description = "ARN of the bucket"
  value       = aws_acm_certificate.cert.arn
}