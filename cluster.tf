locals {
  cluster_name = "my-eks-cluster"
}

module "vpc" {
  source     = "git::https://github.com/Andreichenko/module-tf-aws-vpc.git?ref=v1.0.0"
  aws_region = var.region_common
  az_count   = 3
  aws_azs    = "us-east-1a, us-east-1b, us-east-1c"

  global_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  vpc_id     = module.vpc.aws_vpc_id
  subnet_ids = module.vpc.aws_subnet_private_prod_ids

  eks_managed_node_groups = {
    eks_nodes = {
      min_size     = 3
      max_size     = 3
      desired_size = 3

      instance_types = ["t2.micro"]
    }
  }

  cluster_endpoint_public_access = true
}