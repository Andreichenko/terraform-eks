resource "aws_vpc" "vpc-east-1" {
  provider             = aws.region-common
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "common-vpc-eks"
    Owner       = "Aleksandr Andreichenko"
    Environment = "Production Environment"
    Region      = "eu-east-1"
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

resource "aws_security_group" "eks-cluster" {
  name        = "SG-eks-cluster"
  vpc_id      = aws_vpc.vpc-east-1.id  
  
  # Egress allows Outbound traffic from the EKS cluster to the  Internet 

  egress {                   # Outbound Rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    # Ingress allows Inbound traffic to EKS cluster from the  Internet 

  ingress {                  # Inbound Rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}