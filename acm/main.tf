# Terraform configuration

provider "aws" {
  region = var.region
}

# ACM
module "acm" {
  source = "../modules/aws/acm/"
  domain_name = var.domain_name
}

