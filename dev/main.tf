# Terraform configuration

provider "aws" {
  region = var.region
}

# VPC MODULE
# module "vpc" {
#   source  = "../modules/aws/vpc/"

#   name = var.vpc_name
#   cidr = var.vpc_cidr

#   azs             = var.vpc_azs
#   private_subnets = var.vpc_private_subnets
#   public_subnets  = var.vpc_public_subnets

#   enable_nat_gateway = var.vpc_enable_nat_gateway

#   tags = var.vpc_tags
# }

S3 MODULE
module "s3" {
  source = "../modules/aws/s3/"
  bucket_name = var.bucket_name
}

# # ACM
# module "acm" {
#   source = "../modules/aws/acm/"
#   domain_name = var.domain_name
# }

cloudfront
module "cloudfront" {
  source = "../modules/aws/cloudfront/"
  regional_domain_name = module.s3.bucket_regional_domain_name
  bucket_name = var.bucket_name
  domain_name = var.domain_name
  aws_acm_certificate_arn = "arn:aws:acm:us-east-1:387883916874:certificate/1304a2ac-d98d-4e00-92fb-07668533d0bc"
}
# module "ec2_instances" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "2.12.0"

#   name           = "my-ec2-cluster"
#   instance_count = 2

#   ami                    = "ami-0c5204531f799e0c6"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [module.vpc.default_security_group_id]
#   subnet_id              = module.vpc.public_subnets[0]

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }


