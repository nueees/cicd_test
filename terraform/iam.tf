resource "aws_iam_user" "secho_jira_metrics_s3" {
  name  = "platform-jira-metrics-tf"
}

resource "aws_iam_user_policy" "secho_jira_metrics_s3" {
  name     = "terraform-cloud-policy"
  user     = aws_iam_user.secho_jira_metrics_s3.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "arn:aws:iam::ACCOUNTID:role/TerraformCloud"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_access_key" "secho_jira_metrics_s3" {
  user     = aws_iam_user.secho_jira_metrics_s3.name
}

// 실제로 secho_jira_metrics_s3가 발급 받아서 사용하는 role
resource "aws_iam_role" "secho_jira_metrics_s3" {
  name     = "TerraformCloud"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::ACCOUNTID:user/terraform-cloud"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// secho_jira_metrics_s3가 사용하게될 policy
resource "aws_iam_role_policy_attachment" "secho_jira_metrics_s3" {
  role       = aws_iam_role.secho_jira_metrics_s3.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
