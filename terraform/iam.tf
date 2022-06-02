# "platform-jira-metrics-tf"
resource "aws_iam_user" "secho_jira_metrics_s3" {
  name  = "secho-jira-metrics-s3"
}

resource "aws_iam_policy" "secho_jira_metrics_s3_policy" {
  name     = "secho-jira-metrics-s3-policy"
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket", "s3:GetBucketLocation"],
      "Resource": "${aws_s3_bucket.tap_jira_states.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:DeleteObject"
      ],
      "Resource": "${aws_s3_bucket.tap_jira_states.arn}/*"
    }
  ]
}
EOF
}

// secho_jira_metrics_s3가 사용하게될 policy
resource "aws_iam_user_policy_attachment" "secho_jira_metrics_s3_policy" {
  user       = aws_iam_user.secho_jira_metrics_s3.name
  policy_arn = aws_iam_policy.secho_jira_metrics_s3_policy.arn
}

resource "aws_iam_access_key" "secho_jira_metrics_s3_key" {
  user       = aws_iam_user.secho_jira_metrics_s3.name
}
