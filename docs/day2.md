## Day 2 – Building the Honeypot Firewall with Terraform
Today I transitioned from local setup to deploying the first piece of live cloud infrastructure using Terraform. The goal was to build the network security foundation for the honeypot by creating its firewall.

What I did:

Installed and Configured Terraform: Set up Terraform on my machine and initialized the AWS provider, preparing it to manage resources in my AWS account.

Wrote Infrastructure as Code (IaC): Authored my first Terraform configuration (main.tf) to define an AWS Security Group that will act as the honeypot's firewall.

Configured Firewall Rules: Specifically configured the security group to act as bait by allowing inbound traffic on port 22 (SSH) from the entire internet (0.0.0.0/0).

Resolved IAM Permissions: Encountered and successfully debugged an UnauthorizedOperation error from AWS. I fixed this by creating and attaching a custom, least-privilege IAM policy, ensuring my Terraform user had just enough permission to do its job without being over-privileged.

Deployed Live Infrastructure: Executed terraform apply to successfully create the security group in my AWS account.

Fixed Git Repository Issues: Troubleshooted and resolved a git push failure caused by large files. I cleaned the entire repository history using git-filter-repo and configured a .gitignore file to prevent committing unnecessary files in the future.

Outcome:

A live firewall (Security Group) now exists in my AWS account, ready to be attached to the honeypot server.

My project's code and history are now clean and successfully pushed to GitHub.

Next Steps:

Write the Terraform code to launch a t2.micro EC2 instance (the actual honeypot server).

Attach our newly created security group to that instance.