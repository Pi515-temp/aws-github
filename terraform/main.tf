terraform {
  required_version = "1.9.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
  }
  backend "s3" {
    region               = "us-east-1"
    dynamodb_table       = "tf-ryanemcdaniel-management-lock"
    bucket               = "tf-ryanemcdaniel-management"
    workspace_key_prefix = ""
    key                  = "pi515/aws-github.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      org  = "pi515"
      env   = "org"
      comp  = "aws-github"
      git  = "git@github.com:Pi515/aws-github.git"
    }
  }
}

provider "github" {
  owner = "Pi515"
}

data "aws_ssm_parameter" "gh_org_email" {
  name = "/PI515/GITHUB_ORG/EMAIL"
}

data "github_organization" "dffp" {
  name = "Pi515"
}