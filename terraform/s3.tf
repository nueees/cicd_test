# S3 bucket for backend
resource "aws_s3_bucket" "tap_jira_states" {
  bucket = "secho-gcs-jira-metrics-state"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

