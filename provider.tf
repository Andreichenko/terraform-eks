provider "aws" {
  version = "~> 2.57.0"
  region  = "us-east-1"

 backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "terraform-state-file/statefile.tfstate"
    bucket  = "terraform-state-cname-bucket-9"
  }
}
