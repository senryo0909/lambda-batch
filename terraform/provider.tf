# tfバージョンを固定
terraform {

  required_version = "~>1.3.6"

  backend "s3" {

    bucket = "member-s-line-counters"
    key    = "members/terraform.tfstate"
    region = "ap-northeast-1"
    shared_credentials_file = "$HOME/.aws/credentials"
    profile                 = "Ta9yaAmex"

  }

  # インストールするproviderとバージョン指定
  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "~> 4.0"

    }

  }

}

provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "Ta9yaAmex"
  region                  = "ap-northeast-1"
}