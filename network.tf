resource "aws_vpc" "vpc-central-1" {
  provider             = aws.region-common
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "common-vpc-v2ray"
    Owner       = "Aleksandr Andreichenko"
    Environment = "Production Environment"
    Region      = "eu-central-1"
  }
}

data "aws_availability_zones" "azs" {
  provider = aws.region-common
  state    = "available"
}

resource "aws_subnet" "subnet-1a" {
  provider                = aws.region-common
  cidr_block              = "10.0.0.0/20"
  vpc_id                  = aws_vpc.vpc-east-1.id
  availability_zone       = element(data.aws_availability_zones.azs.names, 0)
  map_public_ip_on_launch = true
  tags = {
    Name        = "The primary subnet"
    Owner       = "Aleksandr Andreichenko"
    Environment = "Production Environment"
    Region      = "eu-east-1"
    Zone        = "zone-1a"
  }
}