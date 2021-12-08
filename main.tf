# Creating IAM role for Kubernetes clusters to make calls to other AWS services 
# on our behalf to manage the resources that we use with the service.
resource "aws_iam_role" "iam-role-eks-cluster" {
  name = "terraformekscluster"
  assume_role_policy = <<POLICY
{
 "Version": "2012-10-17",
 "Statement": [
   {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
   }
  ]
 }
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.iam-role-eks-cluster.name}"
}

resource "aws_vpc" "vpc-east-1" {
  provider             = aws.region-common
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "common-vpc-eks"
    Owner       = "Aleksandr Andreichenko"
    Environment = "Production Environment"
    Region      = "eu-central-1"
  }
}

resource "aws_security_group" "eks-cluster" {
  name        = "SG-eks-cluster"
  vpc_id      = aws_vpc.vpc-east-1.id
  } 