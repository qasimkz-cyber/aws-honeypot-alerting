# aws-honeypot-alerting
Hands-on cloud security project deploying a honeypot in AWS with logging, monitoring, and real-time intrusion alerts


## Day 1 Progress
- Installed and configured AWS CLI
- Created IAM user (`honeypot-user`) with least-privilege policies (EC2, CloudWatch, SNS)
- Generated & configured access keys locally
- Verified setup with `aws sts get-caller-identity`
- Resolved credential/region mismatch issues
