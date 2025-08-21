# 1. A log group in CloudWatch to store network traffic logs
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flowlogs/honeypot"
  retention_in_days = 7 # Keep logs for 7 days
}

# 2. This finds your default VPC (Virtual Private Cloud)
data "aws_vpc" "default" {
  default = true
}

# 3. This turns on VPC Flow Logs to record all network traffic
resource "aws_flow_log" "honeypot_flow_log" {
  traffic_type         = "ALL"
  vpc_id               = data.aws_vpc.default.id
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  iam_role_arn         = aws_iam_role.vpc_flow_log_role.arn
}

# 4. A filter to find SSH attempts (traffic to port 22) in the logs
resource "aws_cloudwatch_log_metric_filter" "ssh_attempts" {
  name           = "SSH-Attempts-Filter"
  log_group_name = aws_cloudwatch_log_group.vpc_flow_logs.name
  # This pattern specifically looks for logs where the destination port is 22
  pattern = "[version, account_id, interface_id, srcaddr, dstaddr, srcport, dstport = 22, protocol, packets, bytes, start, end, action, log_status]"
  metric_transformation {
    name      = "SSH-Attempts"
    namespace = "Honeypot"
    value     = "1"
  }
}

# 5. An SNS Topic to send notifications to
resource "aws_sns_topic" "honeypot_alerts" {
  name = "honeypot-alerts-topic"
}

# 6. Your email subscription to the topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.honeypot_alerts.arn
  protocol  = "email"
  endpoint  = "qasimbaba22@hotmail.com" 
}

# 7. The alarm that triggers when the filter finds an SSH attempt
resource "aws_cloudwatch_metric_alarm" "ssh_alarm" {
  alarm_name          = "Honeypot-SSH-Attempt-Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "SSH-Attempts"
  namespace           = "Honeypot"
  period              = "60" # Check every 60 seconds
  statistic           = "Sum"
  threshold           = "1" # Trigger if there is 1 or more attempts
  alarm_description   = "Alarm when an SSH attempt is detected on the honeypot."
  alarm_actions       = [aws_sns_topic.honeypot_alerts.arn]
}


# --- IAM Role and Policy for VPC Flow Logs ---

resource "aws_iam_role" "vpc_flow_log_role" {
  name = "vpc-flow-log-permission-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "vpc_flow_log_policy" {
  name = "vpc-flow-log-to-cloudwatch-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vpc_flow_log_attachment" {
  role       = aws_iam_role.vpc_flow_log_role.name
  policy_arn = aws_iam_policy.vpc_flow_log_policy.arn
}