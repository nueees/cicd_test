provider "aws" {
  region = "eu-central-1"
  profile = "secho-tools"
  allowed_account_ids = ["623160492249"]
}

resource "aws_s3_bucket" "tap_jira_states" {
  bucket = "secho-gcs-jira-metrics-state"
  acl    = "private"
  tags = {
    Name        = "test-terraform-jira-states"
  }
}
