terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.48.0"
    }
  }
  
  backend "s3" {
  
    bucket      = "secho-gcs-jira-metrics-state"
    key         = "SECHO-2286/tfstate"
    region      = "eu-central-1"
    dynamodb_table = "secho-jira-metrics-tf-lock"
  }
}

provider "aws" {
  region = "eu-central-1"
  allowed_account_ids = ["623160492249"]
}

# S3 bucket for backend
resource "aws_s3_bucket" "tap_jira_states" {
  bucket = "secho-gcs-jira-metrics-state"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "tap_jira_state_lock" {
  name           = "secho-jira-metrics-tf-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
