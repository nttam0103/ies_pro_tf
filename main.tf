terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  region               = var.region
  cidr_block           = var.cidr_block
  public_subnet_ies    = var.private_subnet_ies
  private_subnet_ies   = var.public_subnet_ies
  availability_zones_a = var.availability_zones_a
  availability_zones_b = var.availability_zones_b
}

module "security_group" {
  source     = "./modules/security_groups"
  vpc_id     = module.vpc.ies_vpc_id
  depends_on = [module.vpc]
  rds_post = var.rds_post
}