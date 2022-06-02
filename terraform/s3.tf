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
