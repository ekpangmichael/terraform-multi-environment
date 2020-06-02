# Output variable definitions

# output "vpc_public_subnets" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc.public_subnets
# }

# output "ec2_instance_public_ips" {
#   description = "Public IP addresses of EC2 instances"
#   value       = module.ec2_instances.public_ip
# }

output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.s3.arn
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.s3.id
}

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = module.s3.website_endpoint
}

output "bucket_regional_domain_name" {
  description = "bucket regional domain name"
  value       = module.s3.bucket_regional_domain_name
}

output "superadmin_bucket_regional_domain_name" {
  description = "bucket regional domain name"
  value       = module.s3_superadmin.superadmin_bucket_regional_domain_name

}
# output "aws_acm_certificate_arn" {
#   description = "aws_acm_certificate_arn"
#   value       = module.acm.aws_acm_certificate_arn
# }