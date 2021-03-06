# # VPC VARIABLES

# variable "vpc_name" {
#   description = "Name of VPC"
#   type        = string
#   default     = "example-vpc"
# }

variable "region" {
  description = "Name of region"
  type        = string
  default = "us-west-2"
}

# variable "vpc_cidr" {
#   description = "CIDR block for VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "vpc_azs" {
#   description = "Availability zones for VPC"
#   type        = list
#   default     = ["us-west-2a", "us-west-2b"]
# }

# variable "vpc_private_subnets" {
#   description = "Private subnets for VPC"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24"]
# }

# variable "vpc_public_subnets" {
#   description = "Public subnets for VPC"
#   type        = list(string)
#   default     = ["10.0.101.0/24", "10.0.102.0/24"]
# }

# variable "vpc_enable_nat_gateway" {
#   description = "Enable NAT gateway for VPC"
#   type    = bool
#   default = true
# }

# variable "vpc_tags" {
#   description = "Tags to apply to resources created by VPC module"
#   type        = map(string)
#   default     = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }


# S3 BUCKET VARIABLES

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default = "dev-infra"
}

variable "domain_name" {
  description = "domain name for acm"
  type        = string
  default = "dev.infra.tk"
}

variable "base_domain_name" {
  description = "domain name for acm"
  type        = string
   default = "infra.tk"
}

# variable "name" {
#   description = "domain name for acm"
#   type        = string
# }

