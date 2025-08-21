## Day 3 – Honeypot Deployment and Live Testing

Today was the core of the project. The goal was to deploy all the remaining infrastructure, fix any permission issues, and perform a live test to confirm the entire alerting pipeline works from end to end.

**What I Did:**

* **Fixed Git Repository**: Resolved a major Git push failure by using `git-filter-repo` to clean the repository's history of large binary files and configured the `.gitignore` file correctly.
* **Deployed EC2 Instance**: Wrote the Terraform code to launch a `t3.micro` EC2 instance and successfully deployed it using `terraform apply`.
* **Built the Alerting Pipeline**: Wrote the Terraform configuration (`logging_alerts.tf`) for the entire alerting system, including VPC Flow Logs, a CloudWatch Log Group, a custom Metric Filter for SSH traffic, an SNS Topic for notifications, and a CloudWatch Alarm.
* **Debugged IAM Policies**: Troubleshooted and resolved several complex, real-world IAM permission errors, including the critical `iam:PassRole` permission, to achieve a working least-privilege policy.
* **Tested the Live System**: Performed a live test by attempting an SSH connection to the honeypot's public IP address.

**Outcome:**

* **SUCCESS**: Received the final CloudWatch Alarm email, confirming the entire end-to-end system is working as designed.
* A live honeypot server was deployed and actively monitored in AWS.