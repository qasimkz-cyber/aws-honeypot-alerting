# aws-honeypot-alerting
Hands-on cloud security project deploying a honeypot in AWS with logging, monitoring, and real-time intrusion alerts









Results & Findings
The honeypot system was a success. Within minutes of the EC2 instance going live, the CloudWatch alarm was triggered and a real-time alert was sent via email, confirming the end-to-end pipeline was fully operational.

An investigation into one of the source IP addresses, 162.216.149.225, was conducted using the threat intelligence tool AbuseIPDB. The investigation revealed that the IP belongs to a whitelisted Google data center, likely used for large-scale, automated internet scanning.

<img width="712" height="750" alt="image" src="https://github.com/user-attachments/assets/3d2a6e5c-3863-48de-916c-317d006ab25d" />

Conclusion: This is a perfect example of the automated scanning that makes up the majority of background "attack" noise on the internet. The honeypot successfully detected, logged, and alerted on this real-world activity, demonstrating a complete and effective threat detection cycle from start to finish.
