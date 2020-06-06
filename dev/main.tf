# Terraform configuration

provider "aws" {
  region = "us-west-2"
}
locals {
  cluster_name = "tr1pp-dev-cluster"
}

#VPC MODULE
module "vpc" {
  source  = "../modules/aws/vpc/"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  #tags = var.vpc_tags

    tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}


#####################################
#         cluster                   #
#####################################

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  version      = "12.0.0"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# #S3 MODULE
# module "s3" {
#   source = "../modules/aws/s3/"
#   bucket_name = var.bucket_name
# }

# module "s3_superadmin" {
#   source = "../modules/aws/s3/"
#   bucket_name = "superadmin-dev-infra"
# }
# # # ACM
# # module "acm" {
# #   source = "../modules/aws/acm/"
# #   domain_name = var.domain_name
# # }

# #cloudfront
# module "cloudfront" {
#   source = "../modules/aws/cloudfront/"
#   regional_domain_name = module.s3.bucket_regional_domain_name
#   bucket_name = var.bucket_name
#   domain_name = var.domain_name
#   base_domain_name = var.base_domain_name
#   aws_acm_certificate_arn = "arn:aws:acm:us-east-1:387883916874:certificate/1304a2ac-d98d-4e00-92fb-07668533d0bc"
# }

# module "cloudfront_superadmin" {
#   source = "../modules/aws/cloudfront/"
#   regional_domain_name = module.s3_superadmin.superadmin_bucket_regional_domain_name
#   bucket_name = "superadmin-dev-infra"
#   domain_name = "superadmin-dev.infra.tk"
#   base_domain_name = var.base_domain_name
#   aws_acm_certificate_arn = "arn:aws:acm:us-east-1:387883916874:certificate/1304a2ac-d98d-4e00-92fb-07668533d0bc"
# }
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


