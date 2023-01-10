# tfバージョンを固定
terraform {

  required_version = "1.3.6"

  backend "s3" {

    bucket                  = "member-s-line-counter"
    key                     = "members/terraform.tfstate"
    region                  = "ap-northeast-1"
    shared_credentials_file = "[$HOME/.aws/credentials]"
    profile                 = "member"

  }

  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "4.45.0"

    }

  }

}

provider "aws" {

  profile = "member"
  region  = var.region
  shared_credentials_file = "[$HOME/.aws/credentials]"

}