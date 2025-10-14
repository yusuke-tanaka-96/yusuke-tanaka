terraform {
  required_version = ">= 1.5.0"
  backend "s3" {
    bucket = "portfolio"
    key    = "node/terraform.tfstate"
    region = "ap-northeast-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1" # 東京リージョン
}
