resource "aws_s3_bucket" "tap_jira_states" {
  bucket = "secho-gcs-jira-metrics-state"
  acl    = "private"
  
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "tap_jira_states" {
  bucket                  = aws_s3_bucket.tap_jira_states.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}
