terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source     = "./modules/subnet"
  aws_vpc_id = module.vpc.output_vpc_id
}

module "igw" {
  source     = "./modules/igw"
  aws_vpc_id = module.vpc.output_vpc_id
  # aws_subnet_ids = module.subnet.output_subnet_ids
}

module "key-pair" {
  source = "./modules/key-pair"
}

module "sg" {
  source     = "./modules/sg"
  aws_vpc_id = module.vpc.output_vpc_id
  # aws_security_group_id = module.vpc.output_security_group_id
}

#IGW연결
module "public-rt-table" {
  source                     = "./modules/public-rt-table"
  aws_vpc_id                 = module.vpc.output_vpc_id
  aws_default_route_table_id = module.vpc.output_default_route_table_id
  aws_subnet_ids             = module.subnet.output_subnet_ids
  aws_igw_id                 = module.igw.output_igw_id
}

module "public-ec2" {
  source          = "./modules/public-ec2"
  aws_key_name    = module.key-pair.output_key_name
  aws_private_pem = module.key-pair.output_private_pem
  aws_subnet_ids  = module.subnet.output_subnet_ids
  aws_sg_id       = module.sg.output_default_sg_id
}

# #IGW, NAT 연결 X
# module "private-rt-table" {
#   source         = "./modules/private-rt-table"
#   aws_subnet_ids = module.subnet.aws_subnet_ids
# }

# #NAT 연결
# module "private-db-rt-table" {
#   source         = "./modules/private-db-rt-table"
#   aws_subnet_ids = module.subnet.aws_subnet_ids
# }