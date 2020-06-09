# Terraform configuration

provider "aws" {
  region = var.region
}
# locals {
#   cluster_name = "tr1pp-dev-cluster"
# }

# data "aws_caller_identity" "current" {}

# ####################################
# #            VPC                 #
# ####################################
# module "vpc" {
#   source  = "../modules/aws/vpc/"

#   name = var.vpc_name
#   cidr = var.vpc_cidr

#   azs             = var.vpc_azs
#   private_subnets = var.vpc_private_subnets
#   public_subnets  = var.vpc_public_subnets

#   enable_nat_gateway = var.vpc_enable_nat_gateway
  

#   #tags = var.vpc_tags

#     tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#   }

#   public_subnet_tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#     "kubernetes.io/role/elb"                      = "1"
#   }

#   private_subnet_tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#     "kubernetes.io/role/internal-elb"             = "1"
#   }
# }


# ####################################
# #            CLUSTER             #
# ####################################
# module "eks" {
#   source       = "../modules/aws/eks"
#   cluster_name = local.cluster_name
#   subnets      = module.vpc.private_subnets
#   cluster_endpoint_private_access = true
#   cluster_endpoint_public_access = false
#   enable_irsa  = true

#   tags = {
#     Environment = "training"
#     GithubRepo  = "terraform-aws-eks"
#     GithubOrg   = "terraform-aws-modules"
#   }

#   vpc_id = module.vpc.vpc_id


#   worker_groups = [
#     {
#       name                          = "worker-group-1"
#       instance_type                 = "t2.small"
#       additional_userdata           = "echo foo bar"
#       asg_desired_capacity          = 2
#       asg_max_size                  = 6
#       asg_min_size                  = 2
#       additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
#       tags = [
#         {
#           "key"                 = "k8s.io/cluster-autoscaler/enabled"
#           "propagate_at_launch" = "false"
#           "value"               = "true"
#         },
#         {
#           "key"                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
#           "propagate_at_launch" = "false"
#           "value"               = "true"
#         }
#       ]
#     },
#   ]
# }

# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }

# ######################
# #     S3 MODULE     #
# #####################
# module "s3" {
#   source = "../modules/aws/s3/"
#   bucket_name = var.bucket_name
# }

module "s3_superadmin" {
  source = "../modules/aws/s3/"
  bucket_name = "superadmin-dev-infra"
}

# ######################
# #     CLOUDFRONT    #
# #####################
# module "cloudfront" {
#   source = "../modules/aws/cloudfront/"
#   regional_domain_name = module.s3.bucket_regional_domain_name
#   bucket_name = var.bucket_name
#   domain_name = var.domain_name
#   base_domain_name = var.base_domain_name
#   aws_acm_certificate_arn = "arn:aws:acm:us-east-1:387883916874:certificate/1304a2ac-d98d-4e00-92fb-07668533d0bc"
# }

module "cloudfront_superadmin" {
  source = "../modules/aws/cloudfront/"
  regional_domain_name = module.s3_superadmin.superadmin_bucket_regional_domain_name
  bucket_name = "superadmin-dev-infra"
  domain_name = "superadmin-dev.infra.tk"
  wwwdomain = "www.superadmin-dev.infra.tk"
  base_domain_name = var.base_domain_name
  aws_acm_certificate_arn = "arn:aws:acm:us-east-1:387883916874:certificate/fa4d764d-69eb-4fef-bc70-b48113d3b403"
}



