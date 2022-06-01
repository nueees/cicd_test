terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source = "hashicorp/aws
      version = "~> 3.48.0"
    }
    
  }
  
  backed "s3" {
  
    bucket      = "secho-gcs-jira-metrics-state"
    key         = "SECHO-2286/tfstate"
    region      = "eu-central-1"
    dynamodb_table = "secho-jira-metrics"
    profile     = "secho"
}

provide "aws" {
  region = "eu-central-1"
  profile = "secho-tools"
  allowed_account_ids = ["623160492249"]
}