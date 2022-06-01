resource "aws_s3_bucket" "tap_jira_states" {
  bucket = "secho-gcs-jira-metrics-state"
  acl    = "private"
  
  versioning {
    enabled = true
  }
}

