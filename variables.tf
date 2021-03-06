variable "profile" {
  type        = string
  default     = "default"
  description = "The common profile for aws cli"
}

variable "region-common" {
  type        = string
  default     = "eu-east-1"
  description = "The common region"
}

variable "vpc_name" {
  description = "The name of the common VPC"
  type        = string
  default     = "The common VPC"
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block of the common VPC"
  type        = string
  default     = "10.0.0.0/16"
}
