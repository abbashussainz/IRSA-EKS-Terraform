data "aws_availability_zone" "available" {

}

module "vpc" {
  source  = "terrafrom-aws-modules/vpc/aws"
  version = "3.11.0"

  name           = var.vpc_name
  cidr           = var.vpc_cidr_block
  azs            = data.aws_availability_zone.available.names
  public_subnets = var.vpc_public_subnets
  private_sunets = var.vpc_private_subnets

  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
 

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway


  enable_dns_hostnames = true
  enable_dns_support   = true
}